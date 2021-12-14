Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA4747396B
	for <lists+linux-efi@lfdr.de>; Tue, 14 Dec 2021 01:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244457AbhLNAPO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Dec 2021 19:15:14 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1854 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235853AbhLNAPN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Dec 2021 19:15:13 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDL7BTL018096;
        Tue, 14 Dec 2021 00:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=0llBONh0CnZzAy20yTl+wxswUfM33vV8CBIO8MZYBFw=;
 b=P8TP/Zc10YLFTkgqaHUieFsSoVRDCl8NanBcL5Z+z9EV5z4orWn8vVkPUF4jwQgHl8QU
 9vBE2T2WIwqCaT3cFrjVi/Ud7Ogq+CehXF5wuDGeNOCFwr22onFdM7cGBK8Ur6KHwpAV
 jc0O+208CjNBrC1j9pFbU4/uf1C69hIqMO0KKtDzReXsyLhEQG/byAcL22g9EPOpRaaQ
 4aZ88aFwysxi2h5RX5CoehzyAYbyoYrBlnMwsojf4Vw2jPwZ5DXsEpeRyMtZFBSMbOWG
 SfwHKrjcEX2Rz0xE88Uc5U6HJHEEFX7qn7H7Mpz5VF6HSG9rHMzAhS828z8SGY5UEIgt 0Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx5aka1js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 00:13:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE0Bnmb028377;
        Tue, 14 Dec 2021 00:13:40 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2040.outbound.protection.outlook.com [104.47.74.40])
        by aserp3030.oracle.com with ESMTP id 3cvj1d249q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 00:13:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihcSxRT6mpIHAbQ6+i9X6W/Wd9MQO/Y2spnvdRKojcNkn4wgDTImZDkE4miIoIRNWDrCArggLbFDaA+TkKXX9rLEMJHFNoufxgRIgwd/PkF95h1xLP41dhBjL98RUsQxn2PNEZdcbSJEL5uKCad26BpwZJwOqIUXtfEa2N/QTQHuxUOizpds3St7H08mGM+I9Dg8nPC+H/PuUkN3Zo4pbgHcdxmiGpJaTV59HgBDuKklDKQ1rtA8Iw6C5bM4DPfU7IQvKUDWfho99RXJmYfJ8+qdZqKnHHh2U4dTlNJXTp9Xk3FzuDkrrxLEKoMozDpsN8RcGeMNNoy9Q5TNguy5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0llBONh0CnZzAy20yTl+wxswUfM33vV8CBIO8MZYBFw=;
 b=i6WgXG321nI+vAzBn8ensGSX/azH/toq7YRZju4xoiJpUl/JDg8pynWXuntFE+3zGD+fyya1yEb4mRpLaRF24kQ4o6JnEEwP7jDQJ+IbOpMRE5Z+t3SSO9WWOFu1yxK4E5qzBpxAoM3WRnm975hzirBjWjzxbeh5TO/JgAjt8Iz3C2MZ/x3qFzhtFVLdZbLVavLSaHQdlLSBqhkro9Y8y9888X2N5GfUAD8us1xAvt5dKXpIDZ12BRFH9CHyma5KeiPtmcNcuG95zwHOZNaE1+tAqH/PDvLM2ha0gnjsCaiKs6BrWUUthOWrsy1U2qFycPTQFXwXvzhJrsHWGKs+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0llBONh0CnZzAy20yTl+wxswUfM33vV8CBIO8MZYBFw=;
 b=peERhF59VgLVh+j0eTQL1ds3u+z4nDBnMCXQuRTmKtNbnmVGUS3ESLA9DUfX+8N5Isp4h6cWIzjTUoHoqC58kAUqsN7i0KTzU9qbeBjwbHeCFwIY+olmZd9R3eCgBnhiz7iiMPNPPjbdusS2pbgyfwr5aHt+J2tP8AAfuTfdP9o=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN6PR10MB2574.namprd10.prod.outlook.com (2603:10b6:805:43::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 00:13:38 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 00:13:38 +0000
Date:   Mon, 13 Dec 2021 18:13:32 -0600
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
Subject: Re: [PATCH v8 04/40] x86/sev: Define the Linux specific guest
 termination reasons
Message-ID: <YbfhrBtBw6lRVPFF@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-5-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-5-brijesh.singh@amd.com>
X-ClientProxiedBy: SA9PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:806:22::24) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f3f03f9-fa83-49ab-54ff-08d9be9693a1
X-MS-TrafficTypeDiagnostic: SN6PR10MB2574:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB25749B724C9F0212C155D1F6E6759@SN6PR10MB2574.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5hb0S+WzF++wH/e0oj7WNdUqI0B22fRA1ESHysZuRZsWXDWo0ZmMpVypY199BRoLyjHsUFmYYkequeipp/pF9Zw+DyxuWguH1bsGt7CAXAyogeyCzopOAYmV5JmLJ4nCY7Ul8Bf/LOCnd77XEpBWrIv4Z/EsBDFQsORaQ3DKga2D1MPc2n2iQZK4YA4FQ2n4QWaHipG5nLblwA59i6hAS1abLS6SBuOlX/jd2RzxWs9EGDbb9n9tWhwvAWuccwuxoG+04N6vFai5j9mGaEtfV0RPnaFefgKKyFV54Spm02tN2U0+qDedYCoaugT1MEC6xU8vQnor3TIku3LNoETpdgOS5wv+nfCUCjgpwkkJ8AvxB3rgLl9ox6ciWRqCegI4TUzTbQv9mZw5d9TZjE3QS4V4XEyKzsnGzT9QTBgt/N8fj9G4RhWJjnJmbrgIj/zfUHLjWNxuLbaHkkXVF9z3DqSShD3pdLk7loBE+mQmQRPgiQOZ7pCYH4CFl5wnIAI+lmJc1jOtNE2DKfYV+OFttZAvPgijcO19C0JN2mNmMIM1xSYTt+JjOYhecY0qTu0cYSfvVfDy4PQQ1VRunzFoFr0rkCHpCJ8uZb0+19605KfO1JM4mhWT71hfENHjstFhvIpVPJWXwdTQClwkNXp3Nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(9686003)(4326008)(33716001)(5660300002)(508600001)(66556008)(6512007)(26005)(2906002)(6666004)(66946007)(4744005)(86362001)(66476007)(6916009)(8676002)(6506007)(316002)(6486002)(7406005)(7416002)(83380400001)(54906003)(44832011)(186003)(8936002)(53546011)(38100700002)(4001150100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OozY16uU9OkwndaNYxsgb0az1X1jHfIVs0L3p6sectHvKXT5YyfSHhWUzTzD?=
 =?us-ascii?Q?/9B60EzqljtaAzh/BUF7g2kxhW3nIg2GevYD0vemfZtfZkWgjg6QSfqzzdAe?=
 =?us-ascii?Q?2a/cEF7qR0KEu5xSs7e7oTgzd9LsEgUlwRgpNxOtnT/Mrnlg7IE6e3n+JaCV?=
 =?us-ascii?Q?K93BksAm3RYan0zHpkuTvFZboewuIn2WclCEIJBfsv+ah+cP8VPtHvfVN9Zx?=
 =?us-ascii?Q?IhXP8yFB576aSKs1eW0Pe5ZWnSFRExQ7dfGBN8MKO2mQnzK8Jvn7DbW93VmU?=
 =?us-ascii?Q?Gxu4Z996Dkn+c3vj06TkGLgD8mH00ESJND9Or6Np/6yl2gqXDJAs5b+B/BHN?=
 =?us-ascii?Q?7v21bNWnvYL5SjWBVdxxXlh7y/gwaoXiLNpco0s0mI03F0fdFQra8huKE8fx?=
 =?us-ascii?Q?tyGRuKD/DJKYRyNylzM4pSpOMvM9HRerbfZc67qU60QZP+8fuPvz8doP5CGW?=
 =?us-ascii?Q?GEX4pyecfgQhSguC2xHICPrmdKH/OnKo/1qeJUsvjeNC6ZdJi+tx6eEOu4Wm?=
 =?us-ascii?Q?qQ6CltvzsU2SHwVvwRAZgvQkuzwLApOSF4Lj7EKMEydFVXrcDFaojdsTgFjD?=
 =?us-ascii?Q?wS7M4M3QjMdvuHmAebZINEm2EKSgo/0pyVyRYeQcB1rTs/VEEBtkWf9P4/oB?=
 =?us-ascii?Q?eGDqQK/Y1lVZN6tP18K9RHqtEHP9J5oebALjW3pAkZ6n3scPsPOsVXf+s/Z0?=
 =?us-ascii?Q?NQxJhfOBlxINVFAze2plVBy92h37YpSvutQAqM4AwkGt58Vn/PgbCtqAntQ/?=
 =?us-ascii?Q?VlDoToAbaSRJ67ew4+d2qpvkXpBSXdN5EbnJtSQcPCcogi7Gb4CIRkayjGl2?=
 =?us-ascii?Q?GvhVR3pX+tShguxOmzufYkd6zintxQ94ADkTEiesSZU8hzsb0z2gwBHEDGPp?=
 =?us-ascii?Q?TFszyAuQj7ZJIdUHjvpStP15au8qFHyhv3cLBvrQRhVCnOjnFMcyI74W42cl?=
 =?us-ascii?Q?fV15exnPu64w3PdAmSJuusdtl9fOEcRJ6KQEsY/zXyfH69SXQqENA1h929VP?=
 =?us-ascii?Q?lfQap9tSFBGVgJhfUNIrIFt1Xfb3gL6wVTszlhxwlFRnwls8RvABsWcPlULI?=
 =?us-ascii?Q?lKIZ5mPnSs4r9gkZpPttAlJKwgDbxKDBbc/gBrYTa9KfLbe02p59/pUF7L//?=
 =?us-ascii?Q?g+9VrGfOddhFBi2KfCOI7HjR4l3jqsJctswAK6IOnJE/CxqusoWC5Er8eKeB?=
 =?us-ascii?Q?nX+mC36cf4ztbP+ZrSd0dKx63LAXImX+Z9E/Kd8aJCm0UDsST3GguMM6hqJR?=
 =?us-ascii?Q?twkrUBADc7B5Hin0uK1aJjECvQRTHjITzWrLQbUPbq5Te2v1RUS7fOUGNuRE?=
 =?us-ascii?Q?s98XmTokAalHNAdpdN7Z3NK1lEmLr9c26CGJ99EKwZsa4rQ/Ptdr4yuDm6k5?=
 =?us-ascii?Q?C7JDoV0pwUSBipxz+QshsdqZHN89qvWZ1nkRbzbD3Z/7nofX3fDWjrQPoarw?=
 =?us-ascii?Q?p+thETgfshzvKmS8NWY6bdFIJe9vGvuaV0F+HiSN7logHZX7kocTzKWgkwkt?=
 =?us-ascii?Q?1tWSSp6pxFz84+4sM7UMbqeIcTO+xGJ/nIiJTyZ49ljziGsrBwyTaN0pkGOq?=
 =?us-ascii?Q?fDvZzUYUWPWIRmtk3+7R64Bq35XIVnkPtawykb8Q3Wx7yyyHf9S3LBVJnEFC?=
 =?us-ascii?Q?roO9a6Ns3eSWziV2Hg4qEKMClvOetImmW/OuJIgvo1gRHSXhxudWJHsYGMDt?=
 =?us-ascii?Q?prJU8Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3f03f9-fa83-49ab-54ff-08d9be9693a1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 00:13:38.3240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1wa5pWuZV4DZNXphk3gQTTrYbTMAqPitT9KK9ECJxJg3DCJgXs4Xfmvbi4LdFlBs5LDVvBNfTy3RkmWEwnE11QE5YAkdpqwtFb7IUSPGmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2574
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130142
X-Proofpoint-GUID: vim2D-70DZTnzt4l5qpCu8oxoFiG9Aay
X-Proofpoint-ORIG-GUID: vim2D-70DZTnzt4l5qpCu8oxoFiG9Aay
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:42:56 -0600, Brijesh Singh wrote:
> GHCB specification defines the reason code for reason set 0. The reason
> codes defined in the set 0 do not cover all possible causes for a guest
> to request termination.
> 
> The reason set 1 to 255 is reserved for the vendor-specific codes.

s/set 1 to 255 is/sets 1 to 255 are/

> Reseve the reason set 1 for the Linux guest. Define an error codes for

s/Define an/Define the/

> reason set 1.
> 
> While at it, change the sev_es_terminate() to accept the reason set
> parameter.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

With that...

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>

> ---
>  arch/x86/boot/compressed/sev.c    |  6 +++---
>  arch/x86/include/asm/sev-common.h |  8 ++++++++
>  arch/x86/kernel/sev-shared.c      | 11 ++++-------
>  arch/x86/kernel/sev.c             |  4 ++--
>  4 files changed, 17 insertions(+), 12 deletions(-)
