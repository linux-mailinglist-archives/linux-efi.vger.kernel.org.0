Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DD647608C
	for <lists+linux-efi@lfdr.de>; Wed, 15 Dec 2021 19:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343671AbhLOSSn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 13:18:43 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49750 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343674AbhLOSSm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Dec 2021 13:18:42 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFIGxob011755;
        Wed, 15 Dec 2021 18:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=xLBrYzWVJhy/gu+ciLYb+z1eDKv9Shrde0fjZS14Hmg=;
 b=Ld6Ll7ypy637vA4YlKBFq3hjBLOWTkTyCTfIBJCyCC6QWCZ8CAMwloN/3dVhy0h+H44Y
 WdIxmTjRkWXN/lJIM+1Phjn0iZ5IxtN+EDVBeny0I+uKnhM0PLU/yEns8K4tz2gf1Xs2
 NbuZFN0abPNAqIkdN2NVGB2PMQIfzt5VcepdA0p0Gw2WlR9+lzK0JSOdztJe3XbwDfxT
 Xp037qfX8YaS74OuHGCHufXPXwEcr2I3sW4MOVlYO3GHXRkjIJNi4qmveWII389nTH3Y
 NCgnquWZDUvTXUDII4KiEIEkZGVtJfBvQdIRk1QqU/M+H13BRtyiq8XoQweHnqVi3vyc eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknp0dx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 18:17:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BFIGY7b022506;
        Wed, 15 Dec 2021 18:17:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by userp3030.oracle.com with ESMTP id 3cvh40jgds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 18:17:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THlFVVmpOOCA8YO6WaSeyiTXDJv6fSF5/ml3e6btq2Cuj0NwYuHGiw/0CH+6pz8iL4cYRizub7+gaaUHP8loT4+EhpEi0ACCeB1a3uXSh0Q2qYmRX824IGo8dM+52N8njVxpgirkYY+hzHdZvqClF1QMg9C+jfLnsGTqxI3dheG2SQbmH0PlzVRGs59vsirGOMjm02lf7kaGbfOSa+xNNab2tsK5NriSOt+iv+pxuHajYQQFwVEg2fx/mOqODNt1ZlDDSAAnrIAaOMHAhTdw6bkqtJLjFhGNBNMkTx4XnxdRH/zE3vyniou16Otze1tMOSIkjrqXty+TqQRGAWtOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLBrYzWVJhy/gu+ciLYb+z1eDKv9Shrde0fjZS14Hmg=;
 b=N7o6IWVpZ5c/uNg62+dFM63Ak4i4jUujaA5XNZ3u/gICt1pq27p42Kh0298Uih5gEueyF4tTzZuTtqh8u5LA3IxHI4bIYvsbe2UiJyHu5ypOfMkmLAUDaD/YF4/w140aAPPC4mQKdbFGajBnx3lBlrwCwXg2wuhy577bBH1LTetBvjyFRrDspUDlfHHckP+gyzCZyRpC/PacuztFOntAjnSXFknYFnfLUklVHDXNCUiX4hmlsGYkEheoXlBLqxMlsr9OfVmvpmibN/lZqyJpxjTgX/xwcEGm83RB34Fevb1SF8hrCQI8l9AAUg6V6FQqOOKz9nwJszsBDBnAaJRP8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLBrYzWVJhy/gu+ciLYb+z1eDKv9Shrde0fjZS14Hmg=;
 b=d42wHByEvIETy2eKF3+f4cJy6ZrAgXlRVPOiadt+Q9N7hcLyz4BBAHKja6AryhF697qA1VW8XfRsxBQ1tDwAkJBieycqgJjGhWbb4Tj2dEvEnqivDWVWQcrc55V7tvW3HntoYzD06v7EwSEVA73OJfGzPw2KJFiTMcg2p5KUR4M=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SA2PR10MB4459.namprd10.prod.outlook.com (2603:10b6:806:11f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Wed, 15 Dec
 2021 18:17:53 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 18:17:53 +0000
Date:   Wed, 15 Dec 2021 12:17:44 -0600
From:   Venu Busireddy <venu.busireddy@oracle.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 01/40] x86/compressed/64: detect/setup SEV/SME
 features earlier in boot
Message-ID: <YboxSPFGF0Cqo5Fh@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-2-brijesh.singh@amd.com>
 <YbeaX+FViak2mgHO@dt>
 <YbecS4Py2hAPBrTD@zn.tnic>
 <YbjYZtXlbRdUznUO@dt>
 <YbjsGHSUUwomjbpc@zn.tnic>
 <YbkzaiC31/DzO5Da@dt>
 <b18655e3-3922-2b5d-0c35-1dcfef568e4d@amd.com>
 <20211215174934.tgn3c7c4s3toelbq@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215174934.tgn3c7c4s3toelbq@amd.com>
X-ClientProxiedBy: SJ0PR13CA0107.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::22) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96a648ce-d430-4ed8-c181-08d9bff735da
X-MS-TrafficTypeDiagnostic: SA2PR10MB4459:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB445977CF36A3ADEC3638CCA9E6769@SA2PR10MB4459.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jfJcVwirncO35UwdmuBeSADBarm3/oUkcttbtC26s5ZaT4RPhOQavLQdnF0Fp+SpbXbidxTZquV/C3Wq4a5EghT61Z2vqU1+LCLGorQIr3aDN9JFUzlwIK9QX59G9qIRnxwO9Jqhx5oKySjwPrDQq57kIWY6Ew2LwBS9P8qNnbSCdXYDWMHI9j5yay/tSyfMN/meJOIH/bz0Bahrf68Ssr4jhZI6QkoFMxZHIkHOSOsgvxlHqvKfQgAMcRiyINgdyTsJnlLw7g5y0lJRw299YQOrWBMMgdsmN8rqk3fnoA7y+7x7dX40UHJUKKkkCqmsqO22dp27N1yNbDZvRxBMKPq3jPPxF5v75R8c92Ci77RdO/dkx3xvGzPDwO5nBZgQTwYXeHBAQ2WdurJe6UiKSmqvqiJ+DXnSsJoTxG4QciMcXYS7tfXGmHQ/9DrZ4YO6+Orc/I0+jvbWw/5GCttYb5AriUfzrC/X07Sm8GPhqdMgakkOqolNdtWrg+smcd7bsxx8HnAi7Sb3keYiY+DDl5JOVY5L0Kj8O+x5yFWYubiBJx+/jgcFkgfehO6ZvYeVpHqLQyJ/kXRd7hKAfSium5x6bUZsTcAbWDvcwF/wOgf2HqToSCiw0EHbJh5ASQ49WzCSgkyVJKziq1njvQ0viw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(2906002)(186003)(33716001)(6916009)(86362001)(38100700002)(8676002)(66476007)(66556008)(7406005)(66946007)(83380400001)(6486002)(7416002)(9686003)(4326008)(316002)(508600001)(54906003)(6666004)(6512007)(44832011)(53546011)(8936002)(4001150100001)(26005)(6506007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9lNxunU7AT/b1N1XlHf9YGuaULHpGi9UfFb2lhaV+cz3TkgONNF3qHtkFgjG?=
 =?us-ascii?Q?9PuAMS5Jt3RyojYGVjd/90lY7Ch9IfMITh/YzoPj3NrIH85kVjF3evsWwZ6R?=
 =?us-ascii?Q?1Kq7lIWNo6bGAdZIzmqKqSD8EtkIGRn07TyyZAok674bkyPWUWlZ+JCmUFt/?=
 =?us-ascii?Q?U+5AWH7DhYjQiBzwlUC/uPh45Ks0KPgdLuwi2UN6KCM0vvb7354i78vGGLMQ?=
 =?us-ascii?Q?vkmWyqD7z2wiw84oUka8dheF5IQL343PaOpvKPc7TXXHIeLERltU++SDe73N?=
 =?us-ascii?Q?sHu76ScaAQvxPidXgDyasQpdbR194sfyK21pw5xPnJ08ZVYTqjD8NQ/SgRKU?=
 =?us-ascii?Q?HxZs4dibI5i9w+Rf076AHi5aVSpIdzXTdFPGs/pTtlLjA8G9T5AJZKdZvFn5?=
 =?us-ascii?Q?e2Gr1JT/E2sKDma/2/lcPF5vSEOnQGSzjOYrwfcnl62rbsyyOWj6B5Ug19I3?=
 =?us-ascii?Q?l5gdrILCa3MApJKkoTFTyElBnuPD9fORZmsChOJL9m1HKbwrHdwrE27/wqC0?=
 =?us-ascii?Q?ugN/0sPvXT1Cxu5f6o+ROmOPGSzK294qm9MGSTJC4pjrfno0+Z+NAL12XVN2?=
 =?us-ascii?Q?tENztXpDOkYm5rYTW5DU/mcBsYhkbfehGQVt9HsiyhoXvUG2Tt/XcOtg+pah?=
 =?us-ascii?Q?FNaKFnaOwAgNCQbEUNEsDLvb2vNvBqVzpkipd6Bik846Qa6CnqQ5BJH4Z2DK?=
 =?us-ascii?Q?wFNTvFI4ZeBgfPJKJzMH//bQh8IjSh+peC8k3r0+LHdN4ugQjM1RFdcrYq1c?=
 =?us-ascii?Q?xkAuY6P3Vmho6kCPvklrRMZHKuTGDUTMXw7L7z8m1LOkud6RJQTEvBWdMaAi?=
 =?us-ascii?Q?gvl8lJzVMUplKStHBiRXZJowzCeH6tKC/2iu+Ujt+2U9WVVvU/JxJpuCeU26?=
 =?us-ascii?Q?gVZkGP42oUV9Y6PObjNsYaoQc8I5ZnCrdxqqc1D11GNO02tZ8JxB5JtUAbop?=
 =?us-ascii?Q?FsNwEZACUoQCXVErB5VsRu6jhCf+IhhB8uK3kPobSdW1K7GMliDy/GVomSzl?=
 =?us-ascii?Q?okxSFcJdgzSOywxX4vuAjv0OneA2+sKwJQ2qL7PXSEWL2hq3ewM/EHNMJ3s8?=
 =?us-ascii?Q?uoouLWwdw81dBzRqiZ60vXlarty52ronEys7YZX7px78WIfiOETagPoMzVwt?=
 =?us-ascii?Q?0H6fJjJTCsDSvu2LHF1YnLFOgTBJbGQdrnFB0KRhYadpyLzUYIhMrPydA+Ni?=
 =?us-ascii?Q?wW71Yq/fCl8MG809sAj/eBBM3zHRjXSe+qFlPKUPNcnEX8rDlRj9ReZulso1?=
 =?us-ascii?Q?Afz8zbd3S4eQIvlw/t/c4BfFN06KhrLblSkSplGDNWAx9GOjeq6Mfi7Y0DO6?=
 =?us-ascii?Q?2YE3JflUq0Yz15McZ7NLpXY1j/G+a3NaafN89tdg1kKW6LrFreu/Cy2lAeVU?=
 =?us-ascii?Q?rFu5OFBzbPiUND0iHg195VRZVrfHjR3g+gsGv5RQFZviT6TVaDEoBYxG/TZS?=
 =?us-ascii?Q?U3TeoNQf3NbQJTKFJq1vFp9Kix1+DeVg2uO7wim3WFD0WLajVOQw43+tSelV?=
 =?us-ascii?Q?aKwzd2KfmySR/YeW44c+n23Fc8TaJGi0mELMonlPBnYAbuPaHi5FNBIpWUAS?=
 =?us-ascii?Q?Fkzfu1Nn29BGb42jC3SX/pG+/V/BrcEvC4c5Bq/mby2XhsPKVqK5zYpDqr2W?=
 =?us-ascii?Q?a9DArTR2t6faHdcvDQ659mHs/oxMoxh/8dWlJmUYt37C2DIZbU/gNtIm66HB?=
 =?us-ascii?Q?zpWU7w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a648ce-d430-4ed8-c181-08d9bff735da
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 18:17:53.2890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5etOkLyz3jhXBZKHK+9w1CgshIaKIcEX0t3mu8IMP57IHTyVGYVYUkeDR2tK33Pm2B2lUarQxrIbIHQAMf0dyAvLGMWlQlLzdDC5FR/J8S8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4459
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112150102
X-Proofpoint-ORIG-GUID: k3oaD-QujegTUWoJ_S23ht44SybyS-ot
X-Proofpoint-GUID: k3oaD-QujegTUWoJ_S23ht44SybyS-ot
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-15 11:49:34 -0600, Michael Roth wrote:
> 
> I think in the greater context of consolidating all the SME/SEV setup
> and re-using code, this helper stands a high chance of eventually becoming
> something more along the lines of sme_sev_parse_cpuid(), since otherwise
> we'd end up re-introducing multiple helpers to parse the same 0x8000001F
> fields if we ever need to process any of the other fields advertised in
> there. Given that, it makes sense to reserve the return value as an
> indication that either SEV or SME are enabled, and then have a
> pass-by-pointer parameters list to collect the individual feature
> bits/encryption mask for cases where SEV/SME are enabled, which are only
> treated as valid if sme_sev_parse_cpuid() returns 0.
> 
> So Venu's original approach of passing the encryption mask by pointer
> seems a little closer toward that end, but I also agree Tom's approach
> is cleaner for the current code base, so I'm fine either way, just
> figured I'd mention this.
> 
> I think needing to pass in the SME/SEV CPUID bits to tell the helper when
> to parse encryption bit and when not to is a little bit awkward though.
> If there's some agreement that this will ultimately serve the purpose of
> handling all (or most) of SME/SEV-related CPUID parsing, then the caller
> shouldn't really need to be aware of any individual bit positions.
> Maybe a bool could handle that instead, e.g.:
> 
>   int get_me_bit(bool sev_only, ...)
> 
>   or
> 
>   int sme_sev_parse_cpuid(bool sev_only, ...)
> 
> where for boot/compressed sev_only=true, for kernel proper sev_only=false.

I can implement it this way too. But I am wondering if having a
boolean argument limits us from handling any future additions to the
bit positions.

Boris & Tom, which implementation would you prefer?

Venu


