Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508444837CB
	for <lists+linux-efi@lfdr.de>; Mon,  3 Jan 2022 20:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbiACTyy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Jan 2022 14:54:54 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39570 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231176AbiACTyx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Jan 2022 14:54:53 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 203JoSnQ005560;
        Mon, 3 Jan 2022 19:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=w5/Akrj20LSn/M455HfmjcsEHbBL12eZLxgPnRarpGc=;
 b=UDUG4FjGFh/0QzzejTJ6XjhoUKkYyOq6z7/oK/cMY/pOBiAWJ7xp53k8g1MZT4V4uMlM
 ri246gVUgofyRd/XjLWx/0zUQxvfPipADl0onMevi17luywOoqFNGAQius6RAAbYoIVk
 hmgFBULvVEBVwd0Ew03J811SGEfJmyQSv/iVXRNqGlIHcz76LWPyNhQkPB3DaLBGXB5U
 fSVRLUrwMCkL59cmT0j0AXKRilRvZQliP/mTVyJIKCbjE2WReJFj/MIgMGHeQ6mJkdtc
 DG7O8yhY5wKtu3mHe+UkmHFCRov1ZJKMuIWos1upQVrNiAp1UsX6Zv/t2wfG1jtBU1Hi DA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3v4gk35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 19:54:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 203JpgIi181212;
        Mon, 3 Jan 2022 19:54:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by userp3030.oracle.com with ESMTP id 3dac2va3d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 19:54:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lt/UnYmRdXCS8uL2Obo92ERYx2+srvTtsqmyzp6orSbnFOZ4C52pIi+K269UNa5zLhCzUP4S7cCaV3Uvu/Tdmyj8hfK3EzybJM86tEwW7V3FF4Pzhv7i3d0QzRbCNC0G/TOlPaRSlx2MIGsMlM0vpmMge+VyK71xRIg7DlbKTCdpbYTfLyZdcV14UaA0NUyAKEV6dJz8VDX0ix6LFNtzIz53CJWiejOPNZGOYIySf+in+kccuMI3K8ZqaqiSUoqeAoFySfiqPLOvtPfwjCzTGSqlYUPpEYGG3uvjDc+fXIV/kejWRGegRNspwOSlFG7zBuFAWaehZNp9Yzkw1ymocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5/Akrj20LSn/M455HfmjcsEHbBL12eZLxgPnRarpGc=;
 b=RdZGDzv3DXK3yBPfZU+gvehAjrws96Mt6nmf5brWj0QI2hQm1rTzHQnqeQ5XfAiZ0g9WRSb7LJVgNrrgSzXjr+qkyEc04vEwGNfq0HOUKkmftBZZtXI0BE5EUZpV8/O3KQ9TmKrBbJnIi2rpqxc1FyYxqxrzwTTVGrwwA8haK41kBy9Z5y3+zzUGWXpokEDPXKIzJ2sLiO3xxFOwm/RGgm1YAg6JAoIsWo/qWirRGbDUs62mqxBs0pfVprydvK3qaI6ljW56O0haB2M4sctkg0K2mVuXEM6e32kmHaEAmIJn6yvv8XqCi2w6kCAVfF0nBfaoeUA1iHS0IVObTpwL8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5/Akrj20LSn/M455HfmjcsEHbBL12eZLxgPnRarpGc=;
 b=fupiKHTY2naP/cRsuJBKOYFyWuhAamKjSs4pXdUGSDdpM1C9vWMu24f7xrwkW0b5n01/jHH6J2js4S9AdK52PkW0I2NxM6lD/AKAJLoTPfNRY2Jw2EhaQ1SVO5c0bm/WzBapBef5H+WO8WWYvecmurshvuebK+9+c7E6TRf8wQg=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN6PR10MB3024.namprd10.prod.outlook.com (2603:10b6:805:d1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Mon, 3 Jan
 2022 19:54:14 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 19:54:14 +0000
Date:   Mon, 3 Jan 2022 13:54:06 -0600
From:   Venu Busireddy <venu.busireddy@oracle.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 10/40] x86/compressed: Register GHCB memory when
 SEV-SNP is active
Message-ID: <YdNUXlkHlsVeLfr3@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-11-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-11-brijesh.singh@amd.com>
X-ClientProxiedBy: SA9P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::21) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18105cba-1aeb-4ef0-90d5-08d9cef2d1b9
X-MS-TrafficTypeDiagnostic: SN6PR10MB3024:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB30242E9D5DC2289081210026E6499@SN6PR10MB3024.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcFLK2bnI8y2RDI/fk3XWql4g9vFRSRLSHUh1xkXtRqQd1hive1mnvMouFMl7icBLbDhaUv9qMduxFoIu2z7OttiZpZDfA7Mv8nTM4uVG4UTndxxWpKNytbbta9rzQX+Gak5p3xRTcLo10Pf5dMU5QeS9+3UbP5qrAfSS4cIX0ThjD4TLidvz/i6+ZyCvPFumindbYCss85n0EExGgcgxfPzPuVqnUi89RMNwKDaXX5VdAzKLDGeSD2x/F/IUIsnJl3nLEVbOUzt2Vcp6Kw+6uS7JjTesg9BOXifBliIcA/yvBdx0+JPy46UjgeguOvdj22XzesWWOvVMLEwpYke5plp6LVBYl5Jm/Srkej3IHYV3XgOtWik/+7FBnENs0xzxrGlylV/qn3vTJ/q9/KqE+de6y/csoXYXPU4XZFDO1Owq3//c2TcUWp1q1j+a68idqlzefiY9QPIlgquHzdlvUwZHt93zYvzB+0wefZtUP3Jb8N/AyNoc2UuELcjxU4uj7Y/plL5oSNRdpuR9XpDtjZbqhv4QFE7EDlCwjtvD4LUDjpqQs77DPurUb+diC8BscxVIf0STsuB23PKFejDtjA8NkDpMG0aeIONCA/IS/yG+8oYs8JJPM/99aCLmMGaIiymnf5CNSKgNzogz1q5eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(186003)(6486002)(44832011)(6512007)(508600001)(9686003)(66476007)(316002)(66946007)(2906002)(86362001)(66556008)(5660300002)(26005)(6916009)(6666004)(4326008)(6506007)(4001150100001)(8936002)(8676002)(7416002)(7406005)(38100700002)(54906003)(33716001)(53546011)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yXfst024cLKAHhA/fbsFFUlajVvkfWf3Ucv8QUA/lBTNsxNiTqd8Dy1Ru2of?=
 =?us-ascii?Q?2S1zRraywo4jdOMEv6OEbaF5G4I+1RwU4TWy0FliO9UFvZeNWhgAdrBsI2jy?=
 =?us-ascii?Q?QkhHcDg6fGTlj9bbt602DdjQAX1F5kwTYC1zOACtoJPn/cDTSgol1aSR3cR1?=
 =?us-ascii?Q?7tJfSLRlqSWEk6EkZkgqZ2ZIL/3TLyym7CsoZG6YK4xt/2clafjFxCuyRLdl?=
 =?us-ascii?Q?5oraBmDwGvZYeERcjt71YtOCX8nwf3Rg3zy83SZJ6IJurw1CfBUHKQ9rZ+q/?=
 =?us-ascii?Q?VIP7gc4XKQ53twGMNNcMD4i5IGa/n/ZXnTUrkn+jbuHuzdDMZg32wl+e/nBF?=
 =?us-ascii?Q?m+ayrW50IqSsK+QJtCnIZV5QT11gSPQjm4a4PC16j0Zd8hKi/JBuWJyUgg6p?=
 =?us-ascii?Q?heTYGsjRsHy5XVnLNmCmf1Oj8NgK5fiPJvEpGJ1xT13nJN0d6BOrsXGNm6DQ?=
 =?us-ascii?Q?fVCcXNJXXMP23AB0MR9f4IoPotw3dTdOTLfRJmpOK5asmSVcxx4JridzKAr1?=
 =?us-ascii?Q?8m2j1Rdouac5nrW7v9vWhFvVz3G4bE8XscZte5HMx9lLmpBZefjmF82LrcMu?=
 =?us-ascii?Q?uqI788wF/iPMun/QOgTA+xfdR+mskqfC+FbBibSWlB2nqgIh7CfVxek3uLwt?=
 =?us-ascii?Q?M/2yMZ03FL+1xajFyGL0vmJ/FjagUr2nE/Vv54axwqDjDW4TMC4p++iMozfB?=
 =?us-ascii?Q?SzgehEy545JLxB7l07fMR6LxTWVIbqINETFfbxfprURvVJtcjkpedt5GTHSv?=
 =?us-ascii?Q?YQ0ay5VvBrf91YY4AUTaqdqTUasMUxmolXhNkITLgoA0IzYAyY8GLXFuvhs2?=
 =?us-ascii?Q?gezLssgCWxyTYn5LNsvi7cd9b5VnW09cpZvmzz4iWq9RoqHbST33en0S0bdX?=
 =?us-ascii?Q?fYOXGhkNL9VRJCh9ZFKJClhGRGcvm+8EcTnKX04JVm/DYsMsK6tQ/T7kN7EW?=
 =?us-ascii?Q?iUThiKZGtAbPPVBkUJQTH33ekIWUSjvDBFc3fcI1w+1mXPXQUk4pGe3J8Ucx?=
 =?us-ascii?Q?52aArYB7axdFQv1Xt36v5Vsh5MObVZJK8RZXXNg8Kl1e76hGb6MpKOaP6aee?=
 =?us-ascii?Q?fZB83aZ2Q0iVx9eHC6KcLCaWl3RhU0AJ/BGzk/lnxXqDUFsHG08kmXWu68Y/?=
 =?us-ascii?Q?H3dkfHJd528yk4NkPdEYlFJerIgeIG9VREY0gm5QY7xUe8oyCadjn9L7s1KH?=
 =?us-ascii?Q?PVNHl6k0k2tksCXAcpeEuBEXczTS0tnFX5J7AVoEOnhLOINx2q3Y1HY0hkQH?=
 =?us-ascii?Q?pjFg630BdwtJH3RyqoHGZ7c2ONsYiITFzYEnaxdCOEMj29l4nt0XQEAdXsY5?=
 =?us-ascii?Q?dDxv098kk5VAxFnurSJ0GrpZVHrxnq6VR08o6hlpO0Cr9U/cji7EWiBobXY/?=
 =?us-ascii?Q?hi2tgXlrwoPRGFLAjNG2Q+lDWd6+efbK4trWWEjQfbPfqCvq3YIJJH4PDobx?=
 =?us-ascii?Q?r/Pa2Bv32W8+6wv4frTSUTZr00ms/zmtTM8DZRT9l62izYHBuqHNu7AnCa4a?=
 =?us-ascii?Q?bMz9wHgKa8Yk9hCg9PtA4V/a8cCovTwc3vvp9bq1acXdZxubVL8EGHs6h11B?=
 =?us-ascii?Q?tDYye4f/pbhoY1UnbaTOeQvw8EqQ6mg8wsR76wWpdBRGHHJ+hdOaY5Cj3Kr5?=
 =?us-ascii?Q?IDVjKvGQJl11jRqOoLMjP8s1gDa/tV8msJK7gaKEYSeZhcJr9F3WGYfEDgMx?=
 =?us-ascii?Q?LY968Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18105cba-1aeb-4ef0-90d5-08d9cef2d1b9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 19:54:14.6712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vw0fQQDezJrayk2knOZPqJlMdR+2mDwxvCYBq+1FEQ2nA8dRWSdIsUlsLHnHQrdzEV5/tnIBS8PbK2VQ9cszypTqVsS8pcXTaedpy6bTjVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3024
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10216 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201030135
X-Proofpoint-GUID: OfcnqTJEstr-2enLeDr4HdwKnWRaBltv
X-Proofpoint-ORIG-GUID: OfcnqTJEstr-2enLeDr4HdwKnWRaBltv
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:43:02 -0600, Brijesh Singh wrote:
> The SEV-SNP guest is required by the GHCB spec to register the GHCB's
> Guest Physical Address (GPA). This is because the hypervisor may prefer
> that a guest use a consistent and/or specific GPA for the GHCB associated
> with a vCPU. For more information, see the GHCB specification section
> "GHCB GPA Registration".
> 
> If hypervisor can not work with the guest provided GPA then terminate the
> guest boot.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>

> ---
>  arch/x86/boot/compressed/sev.c    |  4 ++++
>  arch/x86/include/asm/sev-common.h | 13 +++++++++++++
>  arch/x86/kernel/sev-shared.c      | 16 ++++++++++++++++
>  3 files changed, 33 insertions(+)
> 
