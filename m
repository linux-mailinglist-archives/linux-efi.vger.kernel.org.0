Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F79484C30
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jan 2022 02:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbiAEBjJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Jan 2022 20:39:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:53340 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234393AbiAEBjI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Jan 2022 20:39:08 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204NiLSu008818;
        Wed, 5 Jan 2022 01:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=SPFYHnnxrJiSZhrlCahIzCAnpoE13lJ/n5BS6Ai94Lg=;
 b=VxF5U2fX0O8mv9YqtZaXJ8eufs0cEUrmo1Ur7pxbuRhd9r5AgGZnw2qhWeWrbTO0helh
 IpkM6g6Flp9VuYOIO/A3puALnFYBvY6YeTRLyqZflzORQPbt2U4b9hmt2yo3u+N8aHiC
 tg3L5GV+wt00MHm1iUtdKTK+Odv+gZaWiFNjowHddtjwJoxTwE61bRvyqjJ4bG92OuVq
 m5DJTqxGy7tmbq1U3P7NhsJ+BsJL3jQ1AzXf/smvYvt5ikDl9QqXmbQYk+3PdQXkUIlP
 +F+k4OyaUGV48Opt4Dll8jttcr+0YbV8z4a7AbXo3dQyUbQI5lew/AS+UG2rF8f6f1hz oA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3v4kpry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 01:38:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2051ZkDr173356;
        Wed, 5 Jan 2022 01:38:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by userp3030.oracle.com with ESMTP id 3dac2xfuaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 01:38:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1t0n/2NNAJUMW7oAyJWz52cIowieN9S3YNQNT5gCEvfkL3ElPS9zTLyit7JbSEB7DLXFmkSmlVduz/EUpByBZPgES8sJjj1sEzStM25ok/pqDqWQamajI0+A+t5jfugPEHo+DrCI3xDmldNHgJJJN3DrrgEs1z6BFSD4kqrSyexX+TqnNW0s+/QJW2rHVXrFWCCLzBnPLt5npYOi7/Q/hBuqHCQrYdXVTkP7Kt876FQ+NkvFay79wkdZm8q3vfBC41+DF4zTxIQ2QB04Yx/MfbCNOQmuNv13oyx+kig5eNT0F3JNMmDxNtlGH0oPMuGEcNHgcB7ROm0gOvB6JNZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPFYHnnxrJiSZhrlCahIzCAnpoE13lJ/n5BS6Ai94Lg=;
 b=kq14qL79C4jmVoyciR76cvbO9i+34XzCu1B3k0qVn1wyDImZUQ1W7kCP24+s1X2+QQS1mPpYS94R+tVh7bomQFaKuvTh9xOb8JhhLUMR5WUCeer5jTk6mdCJXC0jQ1zoXRyDnd+dcoX0Xe+1bmdZqPnRuEMvotJ1821/Ft0UOnBI/uqH9bQ8hLJDdiiA5JGz+81L7pyzGV5BetBBFVNBcP6FYUP62nwF7G/oXKyFv70c3YRaSfWclV2wV+eceO2V6CkiKuog8wASUn0DhA4UQ/dWQ5pP1MdpYiaHABsvw7O3ipEINWd/UqNIH/GlgvKVhaKCd0O8Alzcjy6YTQWteg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPFYHnnxrJiSZhrlCahIzCAnpoE13lJ/n5BS6Ai94Lg=;
 b=L4G66K27CxL0CQ+vPgXIvcV4VbJSJBMRayKnfWW2aaqzeuC1geecfcrH9jK0/8FxVHGRsQD8msTwuZcsJzvArZpDYLL3z9lvZBcwozoVbBuObZdmXdorBdvVcl75zq56wu0DdO8OhV3jY27U8wtHg9V69ovKaso2mhGhH278wJ8=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 5 Jan
 2022 01:38:16 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 01:38:16 +0000
Date:   Tue, 4 Jan 2022 19:38:10 -0600
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
Subject: Re: [PATCH v8 17/40] KVM: SVM: Create a separate mapping for the
 SEV-ES save area
Message-ID: <YdT2gmB7peuEHPLx@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-18-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-18-brijesh.singh@amd.com>
X-ClientProxiedBy: SN7P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::21) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea45a376-cfee-463c-8255-08d9cfec0b6b
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB46846C880440665233F5AA37E64B9@SA2PR10MB4684.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6j9HCgJ4THNFuvX6xRxxN9W209NV3fpFbOpOWLRjfwCOsUpQwfedk6qlSb5IQn5i/t4YEMoxs7sXh729/6yb7QdE2uxC7HOxWmgBur2benta9RIFmpsV25vzIyGN8E56QVw7KK7JnszoqHcj1nr6vPmhwdkAMPGcNFddTsoZm4udkJ7OCP687Bls2PDb0ar+91mB59ylV86itHBjp++90mO/12WZG2T0IgqQApPMhP1ifBSX81RtRKZ7KNg7zLMlrDnVC5SmF5Ufog7o380dc91QvtBxX39v7aETmcAlB9pyeWhWoRm0OCyiMXNWhQr4yicJKRYbrhV+PNdleQzALfHYC4ibDYsa7EiP/YbLgzDlzJzjRYEL/15HaxHtR4niVVH3SUFNCTG/6rQRoFxQuZOr2xPsIFYQtMKTlJ7MkoPtrmwpfHN7m/Kl6DIrKlkuhScsJBXXT3vwDn1xztB4Pb7ON77yxc8AOHfTjTb/Wn6R+t5hfBVpQBsAqrcVFW2sm7XE6Bi5iEZb2tpMCPVQgFS7+P422it6FBP/P9bUBGTsdEJnqD9wjoOOOhuMcxJhCh8jLZCaUR1xp+3/6Ghq8Z/zsYzc3Om0JnpQckzH6Zmt8dGab/9JrHuzY1PwxFZcVtQneW1N/idiTSgBWPG0cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(2906002)(4001150100001)(508600001)(5660300002)(66946007)(316002)(66556008)(4744005)(6506007)(186003)(83380400001)(38100700002)(53546011)(66476007)(7416002)(54906003)(6486002)(7406005)(4326008)(6666004)(26005)(6512007)(33716001)(8676002)(9686003)(86362001)(6916009)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6LFvkOQ/MC03ScUI12HJ8a5XNSnxBTKU130i2aNv+B6DfXleXnBKo/TqqqBo?=
 =?us-ascii?Q?9imhCGAnQaCcRgAB0AeD0e7mM9d0IbZZu4o2A+U6FaiJHCLd8IzgugdCLtqE?=
 =?us-ascii?Q?PTzT+JoMjq5fccOmzztayI5e0jNGJyz0wvjkUXmbGxv3wNKhUutNrgyOYPOq?=
 =?us-ascii?Q?eM6vfRhfLfi4OhXQMBFKIiRxBf6UKutZ/ei3V6TnhoaywLeIsaMX2UQ8KvIq?=
 =?us-ascii?Q?xHbcG43oEGTf27KdSOWwcEfAD7ATd7+SkZ30weq1u1fRa2ISwR2hED3cocZE?=
 =?us-ascii?Q?Rr9hCVaW2cY1D0PnTqOXGsWhVYbVyXm4bxvrdErV9F4TWD57Ib/dhQxLRYWN?=
 =?us-ascii?Q?JfyKSoGpteoMAwhd7Q0RM5FGPZ/czLP+yX5/yOFK1xpj+U5pJRoLyMQFVc6o?=
 =?us-ascii?Q?LAVWOeYH/AtuEiCmDOSueaImXSgfm02PYKuCJqnvLtPlVRPZFEz29rmILrAC?=
 =?us-ascii?Q?kpoiMnKSsdhOoq7kMEchq15SreeYs4YSdQgvvEgAaCXwSPmbVYjJldWpJKbI?=
 =?us-ascii?Q?qRj7JBPSonP7l/SHsWZrLueKfK6KzkJiSM4gJLgvRos6hZkOBN+ACiSPWHWl?=
 =?us-ascii?Q?Wi2OfLzn/NHuP/M7IrPd81/ZygKAWKnQ4hdREJNRx22evU8xCYnwe2Ran/HS?=
 =?us-ascii?Q?R+Yv4qhosqVImRX4aSzGkdFT+155G5RZIKDtNnO0UgNHNSI//3pxswh8Er8C?=
 =?us-ascii?Q?1czBActD3GUXhg8KRpDWPTMRNi7kSrdR0RVuLQXedmGYoaUo8nnpy+ZDNi9k?=
 =?us-ascii?Q?BFGUUkC89PgWgWSotEmJAYmx4fpjFACCsOsXKUhtNv1LGPaj81WEdhhDFunw?=
 =?us-ascii?Q?aG029vsastOlGtAOconTlislw+zJXkMnM/M/QoDTpl5eIWgNfi8tWs3g+gOj?=
 =?us-ascii?Q?T8y3IoSS4+GXrJSK+Ut6EFD62vg4DIB0eog/bRb7UPfUK82J3aVZpSaTmdX2?=
 =?us-ascii?Q?dR2Rdxy21jyxjvE0ylWXOy85xZUidBmUuogVINTQdv+wQj/0h7NJBV2iHv7j?=
 =?us-ascii?Q?UYvO71s4Xr0fmh5XOjaa+73zIWwyeLulswDrRxQxpZODR1fEGI8KKnT2bXI3?=
 =?us-ascii?Q?l3xhDhmiwv6v9lA/1qTBMYE4bfsGN1RHlicogn6CjGxnfeO9a6sOnLvxcOzN?=
 =?us-ascii?Q?g/64N6Jw79Yejbo7/a1QPt/4BDMBFJWfPvBCugeDo3dBg18hsPjOwx+dV0cX?=
 =?us-ascii?Q?mg0HmD5rN4AMU5eM4CICRqSqMKp0YT2IsKfvOnShSSmef1kV1abF+WR7/3T9?=
 =?us-ascii?Q?CFqgoGyy2DExMXFPwKRAilHzWxPNWetdJPIDnPaRDbazdU8GwIh5LrYYUxUA?=
 =?us-ascii?Q?Ki1IDYPAeL/fNMa/xLf4x8wYnSCH6zxmJ4eA1sSqaeW0FRoF0LIUCCFrVlo+?=
 =?us-ascii?Q?J6Hx3/5fysyGcnzHfcnmNoz1fRQxYoF+p92SM+eThHWrHlp7RxGad7PQBZqh?=
 =?us-ascii?Q?aSZKVYj+bdWUszuWMG9xfXALO1Kq6pjLgLN/mbtwrbVlilVqhyfQalVwT7PW?=
 =?us-ascii?Q?8VPEzyv0+Ku0UkdSt4QjmIFr3oqdEDh5zxdnwI47Acdkl/whNNaDWAi0i/la?=
 =?us-ascii?Q?Rrm94YFjfDjSegT0iQfgbssKQcY77JCOFQOa4ako0haptFoThkbj9GW6YgbJ?=
 =?us-ascii?Q?Ptiy4UjkYLb4PWvR6jiiEGreKsvq4a0EaHgfrLBCxcxgk+tzn+DK8dTsi2u+?=
 =?us-ascii?Q?49BJ3Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea45a376-cfee-463c-8255-08d9cfec0b6b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 01:38:16.2841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkQJBXb/cuZDSuo2z18wW7lDDMQTJaixyZweb21La9EKZaI8V+ChkIowJgWehORq4mKqD1mF0GBBTRxRfY6NECbK8fv+NG5DRi7YOjgpiOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4684
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050008
X-Proofpoint-GUID: kVu7iPD3N_j4YzQRGOncqG2jZBsvpen5
X-Proofpoint-ORIG-GUID: kVu7iPD3N_j4YzQRGOncqG2jZBsvpen5
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:43:09 -0600, Brijesh Singh wrote:
> The save area for SEV-ES/SEV-SNP guests, as used by the hardware, is
> different from the save area of a non SEV-ES/SEV-SNP guest.
> 
> This is the first step in defining the multiple save areas to keep them
> separate and ensuring proper operation amongst the different types of
> guests. Create an SEV-ES/SEV-SNP save area and adjust usage to the new
> save area definition where needed.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>

> ---
>  arch/x86/include/asm/svm.h | 83 +++++++++++++++++++++++++++++---------
>  arch/x86/kvm/svm/sev.c     | 24 +++++------
>  arch/x86/kvm/svm/svm.h     |  2 +-
>  3 files changed, 77 insertions(+), 32 deletions(-)
> 
