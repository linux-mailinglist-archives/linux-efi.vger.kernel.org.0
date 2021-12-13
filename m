Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1FA4737E8
	for <lists+linux-efi@lfdr.de>; Mon, 13 Dec 2021 23:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243844AbhLMWtZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Dec 2021 17:49:25 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26712 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240684AbhLMWtY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Dec 2021 17:49:24 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDL6oHk021570;
        Mon, 13 Dec 2021 22:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=uiJCdhA7qxPYUDMVcV/2rHLK8A7f/nm3QdTSRDtgGJ8=;
 b=xyad6+5WpBHdXkRJ7IjeUh512GH7tbmZCF4OjBDIIazT6Pe+gtr5nlxn77R+asn/PNUM
 dx5NrNossTJ9lZj0ueq1I4LmA9AndJp75Je4KSmT2DHm49Y2C3PF4XUsushepG7UJzqb
 sMhgd04XHiZG8VoyoIwdpvkMlxG27+M1gmLxsTssis+GvilBvyQSAvA4NsoCbCkeMnwu
 ZpfSVOQwWiTt8OLma4eco6GbamNJ1ARBX4m7tb47BkPTHO7+9+ByKl8Em9aTnx6roEsM
 xgt9cwAYg/ZnVnir+VcR5ebz433PbMko3ZGXmjM/I+rVv+03KI3suaeKQiDsBv5YtyeU CA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3uka5e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 22:47:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDMjmEu122216;
        Mon, 13 Dec 2021 22:47:55 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by aserp3030.oracle.com with ESMTP id 3cvj1cy0bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 22:47:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAjCiqP0xMErb9LpZaqzS53jgZX605pW42g/qjyIz/bx/u555YruPmspKKd2rhL3sJ/o63Dm9uW3iYhEytSN5OcgIzUBbjIV5y62NH5VhmcQnuY+ZqoxDXEYx0nYGOsNRky+0seDQEZQxdhstS0KtKOEmFr0B6A/gY6dY9R+HJbQ2Tqvb8vPYmsZsHzzuHX0W1v0jMMXT3QyIiKmW99ao/NI/6MZXHQR5FdDhAL3Etw38nm257PRReUB/9jFJfx+dOkyIUDViJQbPUCqnpjeDIB1BCJBTDMMuK+QHhkmG9vVH8QCufa8+Ipr/C7HJjrE5KZ41jlXDngbbJXxJPxyjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiJCdhA7qxPYUDMVcV/2rHLK8A7f/nm3QdTSRDtgGJ8=;
 b=nC6I2DX+U37l5eAtfeEj+fFliGIZMdtuJDf4XROcOKwjFEx9zNPvej5Ps084gq3VkHGVDSyzViSgMIDUCTloTzl7XGpcr7CFwhPOgq4MZiov0IgsWnJLlFVQmjKgJArsE4Pit1uJW5KfONDJAHdGSWd+UuIMYKAh2k7qEx1KSJDTseQN/kJPXbmKvIJsc8mKW83lBBaN5Mlv0jV1RYgEe7Q8+qKPV59G1oykZOXgQwIerIm97rvSxTgVY5I+xwvCXWrNifJY3gcfXlKmh9ErMHfyX1MaQpGBUq8OwW9ybMGu5GGmvfK5jF4Lpp8uAYVq5b3w69bDVPHrPnhEmRAuVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiJCdhA7qxPYUDMVcV/2rHLK8A7f/nm3QdTSRDtgGJ8=;
 b=dsQV1KqOUpPCevU+yWKCUZMSbx5qiHWTbGCztuB5OvtCKq/gWJBp7wjhlOfx9nhGZaZQhZboEhs1dV2k3EyPFKi31AFD3jXoxKUWPwmgj3YnaAAOSxrHf973Eis2oV7ezbC/7lRgRUHvSC3IdROOfB1zpU9p0+Di5ibtqaJi3lk=
Received: from BYAPR10MB2567.namprd10.prod.outlook.com (2603:10b6:a02:ab::19)
 by BYAPR10MB3606.namprd10.prod.outlook.com (2603:10b6:a03:11b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 22:47:52 +0000
Received: from BYAPR10MB2567.namprd10.prod.outlook.com
 ([fe80::d9c7:1443:72a0:6543]) by BYAPR10MB2567.namprd10.prod.outlook.com
 ([fe80::d9c7:1443:72a0:6543%5]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 22:47:52 +0000
Date:   Mon, 13 Dec 2021 16:47:48 -0600
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
Subject: Re: [PATCH v8 03/40] x86/mm: Extend cc_attr to include AMD SEV-SNP
Message-ID: <YbfNlKtQR+ek/CTc@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-4-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-4-brijesh.singh@amd.com>
X-ClientProxiedBy: SJ0PR05CA0115.namprd05.prod.outlook.com
 (2603:10b6:a03:334::30) To BYAPR10MB2567.namprd10.prod.outlook.com
 (2603:10b6:a02:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1071ce37-575e-411c-224b-08d9be8a98a2
X-MS-TrafficTypeDiagnostic: BYAPR10MB3606:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB36068A892D189332A0931F1FE6749@BYAPR10MB3606.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SEqej8zGad6fX97ZR+4tJOcYUANhM7zUdMn+xuIh0VRsgf6WK575Q2jnzf13GnShh6kH0c5MhsiqvYbik2q39DS/DYJaSnJ6G/dgm0OaUrIO1DdmnEugux3PO6ZfuRdyipf6XtRTFYuOsMT3ByxEYNvU5zU5ug3xNq6SmuIHE0GNQuUi/25wmvwbxjR5NNWBruxJ2uUYIeSnV0bpkP2PdEs5q8YZP40RlYQdFa0YktQKGFMhPVwLlGqjxcad1g2+dqbKg6pMOPLTHYh9jrnhOaveMH0ahj6ZzK4vsAETy2ub/wzl5jTLFH4f1L8IAqxBol8z3dIdkvG4QuMesxMEGeCxlnQr8SP5FFSIky4lZxm5Saj+zwFlilWMZ7O0qOxrWViujaDudl9r9vZs69n/a29QKe0HrXGmhMBK46zQvvZhYCjWg0vmqF0xKU9DP4X7M4y7e1JdFVRZt7S/Cr0LeCxJHzfeOyCbZ6+x8VdPJrS+GIrnc8JzFlmKCeoSMVpFMIIPVDm11Dsc5G1wRVdsQoRX2W2V0XxcDJuazE8A6HNLggOC9aOqHbKcgWqSjVrdmqgZFEfhFLo1HHam84N5AU2Q487dkrkCc/ftMKstyc/+XdE8udg2v0WPMu4pgkih1uXw5X+qa4FDkgj2r9LNGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2567.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(8936002)(6666004)(8676002)(38100700002)(86362001)(2906002)(33716001)(9686003)(6512007)(7416002)(7406005)(4744005)(6506007)(53546011)(186003)(316002)(66556008)(4001150100001)(54906003)(6916009)(6486002)(44832011)(66946007)(5660300002)(26005)(508600001)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X7en9DEPZpufE5s5kHEVnUhhL/eg6A2m8Cn6eF9rKo6i7lW7L1TPfu0Yi+EO?=
 =?us-ascii?Q?v8blhBCv5YuL0tfEMf83UiONe5IzO7whEauY8XXytRv4rAFboTGUy53sD86V?=
 =?us-ascii?Q?9VSAIBpWvUDGdAtt4Ybzl+Jyb8kA5P3YOnQYuN6vuZbhPCYhzoUlkiZnHytM?=
 =?us-ascii?Q?nvgFXuWA1Dytj/sntFF5l3eV9MgvkbLXZ0fkJVexj8m01Jokvup+Hiqnk+4y?=
 =?us-ascii?Q?74rhiCvJjQzT2A1K3lbblVEodZHpfxivOJG9Dt1IlPU+2bSSiK7ElCJclykD?=
 =?us-ascii?Q?TNzZoXHtxN2oGyAVMUaP4+pBUymjvRI/HFNXIL036CJ1WYPxDU8vp/K9jvr+?=
 =?us-ascii?Q?q7bY563ZI8Q3pYvzWqN9pVPZfIT8iGIg6eMcLidW4+QmZyovFZsxVqrfi0pG?=
 =?us-ascii?Q?PDy4GRFXjUvABFdycy1CyCBZCfm1QoDbHe7LpE0SUFo5hEEB1nS5Xd+SPF20?=
 =?us-ascii?Q?xL/FyRUYc4KAEZ+TO1g2ZQwcnIz1HEh1kmCG9bHre8t4NO0oEejyd2kA9pcl?=
 =?us-ascii?Q?O5ubPeCDGOVx7FkXtdRoe+3TqfR0In5YXzaiNRMe1e8kjKXpt2ZFlYoRf7dk?=
 =?us-ascii?Q?gA9ITqL1YkWmzbIpPmYXdN/lMGDEcgZhNTvS4uN+FNWfTQhOD/da8Q9QEx0Q?=
 =?us-ascii?Q?ba6zxFNOQ5ifNcrNcq8G7h4f6iNVkUQq4lf/BwlEQ/bkcfCbk6HlG0dwuJhL?=
 =?us-ascii?Q?/MCRvVeiJFr7x43y5MkOWjcJg8HtWckGq4iiis/KtDZsOPf3zhLhlOvfYsZt?=
 =?us-ascii?Q?z6WDcx6T3lt96knx01gaf/fmNMtdHlfuo+xnFfFK6/p5P0XNnsULU4BvoBJl?=
 =?us-ascii?Q?rHMuVufzjnEF3+03ICgaRSRQwy2gSP7gBMV+iT+lz7BNtPLbnA4Vq0+zDdyV?=
 =?us-ascii?Q?dEva1AXY1fgtqc7zbXIJH4DuVvLtesKA9qqmlmzseQOxdlAgizemqafIDUwn?=
 =?us-ascii?Q?cHGqqYOkRtW9q4FOkx3Y+L01SIV2uByXS+HJ0GOzSkMVW1FWa9JFP0GbHgr/?=
 =?us-ascii?Q?f9Nj5lthW2FhkYwNTZQoKW79txcW8rGBChRfXzUN9ZIpxBtmhoi91wVQe7d/?=
 =?us-ascii?Q?iyJp0IELpjjUo+YVGCoxZ9mxiX631BvVRz94YQ4xrMofd6x6bYbTsGelvm4/?=
 =?us-ascii?Q?hGSNmltBwQCT7kuQnSZiD+M9PqKIwNdGVneVkoeIs24LngiN/uX0F8637TeH?=
 =?us-ascii?Q?PpRirJ8qGBb3zTR6AnmcFCyMLVWEPtgCXflbD42hmUwTgG+p2iXa2MYTSz0h?=
 =?us-ascii?Q?SgpvkC4QYXgm2CaNisoLRWuZ+VQ1AgejQLjvLEjYdXHju8vJ38NSNkurwz/t?=
 =?us-ascii?Q?kTpjc9kemR6TVDMVUZ6bgG8tPTLVBkrKe+X2pGGEdtVIqlbEBDrlBrWMJW5g?=
 =?us-ascii?Q?7KdOIJ4hwdCWthAghf/TEoGTjBgYjq2QSCEAVG1hrbGqr30gASSRlWyfatks?=
 =?us-ascii?Q?fJptHAsa7Pt6c4HGEavEQbUwWovLvTqn07t5wdc3PytO06Yx+kq6vWjFx119?=
 =?us-ascii?Q?rwSg8vfp9Bqo+YaJ15ILrWr0Hp0PN49LmP54Jvj2JMX03RyNL7r4jFPYNvAS?=
 =?us-ascii?Q?W/YcpUraidtM5HxqIVc3oR7jHNcAxal4olQcsgyKk1l+ksvgiPE0ZK6I3Bim?=
 =?us-ascii?Q?CiSS+J0mJsH6JvHiUf+FWjqTbmCivsdAQ1NEYeT0MpvH0nDmWwAZB3osMsNL?=
 =?us-ascii?Q?c8hpTA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1071ce37-575e-411c-224b-08d9be8a98a2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2567.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 22:47:52.6271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMNZ21wmfxtPGEX2oZTSnXVOQqy5Hu/fisgIskxPSHKoZW7wzz+7cshxmEvrT810WkNgnG1HDMpVok8QpAUOGKWanXQOAariaE9iBywkd/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3606
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130133
X-Proofpoint-GUID: cfzaTVi6M9Hg0vkHGfY2yoKfDNj5iKa8
X-Proofpoint-ORIG-GUID: cfzaTVi6M9Hg0vkHGfY2yoKfDNj5iKa8
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:42:55 -0600, Brijesh Singh wrote:
> The CC_ATTR_SEV_SNP can be used by the guest to query whether the SNP -
> Secure Nested Paging feature is active.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
> +
> +	/**
> +	 * @CC_ATTR_SEV_SNP: Guest SNP is active.
> +	 *
> +	 * The platform/OS is running as a guest/virtual machine and actively
> +	 * using AMD SEV-SNP features.
> +	 */
> +	CC_ATTR_SEV_SNP = 0x100,

Perhaps add a note on why this is being set to 0x100?

With that...

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>

