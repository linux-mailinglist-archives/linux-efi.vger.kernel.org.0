Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B010C474EF0
	for <lists+linux-efi@lfdr.de>; Wed, 15 Dec 2021 01:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhLOAPh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Dec 2021 19:15:37 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45768 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229452AbhLOAPg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Dec 2021 19:15:36 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BEMSrrj017629;
        Wed, 15 Dec 2021 00:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=X7A7joZduBb98NPhHdymDsX7lVFVZ/DwFqjUuaIjI2s=;
 b=CeZR631Tu+iVrD0t6YknQqC6009re6zoCT0DdIHejgQhwfQbcWhkbZL2uggqrCwqENmF
 I+oGjBAho8Zurtbmv0FvUshiAPOJwiEbDDiNLH1WeQ3UESUnzd7oG1mNrLLD1iEA4QoM
 bCsSZnp0xvpwVQNV6qvvkKKzpUqQH+9hf5Mk5lqzWkjilHeOxt6srappzWtxHmgJBsSf
 PHXlCFgmdnfKJz9Y2iwy/QsX/JF4lHMaBwpbdoir4Wr2ZAI5aysQzmOONcpwmaXfP65F
 yJtvPASw/sgDmRbca9VKkAmbjKhi0/33MzP9n6Ub6/CX/g1ig/eYJ53Csx9bJkgLZPC2 mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx5akd4f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 00:14:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BF0Bddm158019;
        Wed, 15 Dec 2021 00:14:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 3cvneqw9yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 00:14:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtQPvQwT+j2EtiCiLMNywNdv2tcTHKqRxPRUPFHFzGWXZ80c/1vKQvIuPY+r1PhfwmLix3qSO5iwZCvxqr2NQcAEFFxZgTPBvBwJrYSN0ONPjPUriMO1luUrdea/RzZayNy105KexrP4zrQeL7J96i+8HFANuPwrS8zXhcpPrODx/iqQbKMEh2KXgvJs9u9NyxM9JxiIbtGVK5g9f5oeqBcxza1al77poI80VFv/yDGJ4SLTa4bTRcGktlotAdKqaQx9Y0DU/AAlTBOQNq/vGJ2RbYzzajCr3LkxJGC0WJCPK6VVih3ACuw+bJgyw+ruE5JXA69CIAMOJeZXZPt0Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7A7joZduBb98NPhHdymDsX7lVFVZ/DwFqjUuaIjI2s=;
 b=GEzxeTnsOBGZw+ZQH5bRXUgp645/IoUK97qfysCG3mRXcPCmC6Q8eOSgwZoSkXS7Wg9KkeGHNqvzPOsAg/aD5uIgWkenLvjv0nNixBLHnyPe9w/fYMyC+kj5ZyjF9rBQ27b5ZN4/oUUTvLhRJl5iXlE5ZeY1hXvU0yWC8x65e1XeHwAw4cM8lCuLQXpKTo3RZd9BYWvH2JNfnl+0/aGCboo+xgi1emGHp2VimEOHEA75VBS1ui2wyhxK0NO2xhe87i+O43CEzKHnJkh4esCjCanBcXvvlVjncG/F2I1YEyzPUW9an6CUFCX1t1YcDrRCga2Xi4m4jHLi37vd4INPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7A7joZduBb98NPhHdymDsX7lVFVZ/DwFqjUuaIjI2s=;
 b=YtMVrTfj1GegfUTho08nOPTJoylzSKnpzbi/iosWc5o/hgLzXKjvEKKxLJsW4y2Wktzx8s/8+Q0jUUeGEEBZ67/MDkrLMyhViLV8vWZAoSbIePib/TYBfRs4xbBXYtvM4eDJleBxarknOhVUj7ZlZNSzJ5YRDE/Pq+FcFBP4o1c=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN6PR10MB2829.namprd10.prod.outlook.com (2603:10b6:805:ce::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Wed, 15 Dec
 2021 00:14:43 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 00:14:43 +0000
Date:   Tue, 14 Dec 2021 18:14:34 -0600
From:   Venu Busireddy <venu.busireddy@oracle.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 01/40] x86/compressed/64: detect/setup SEV/SME
 features earlier in boot
Message-ID: <YbkzaiC31/DzO5Da@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-2-brijesh.singh@amd.com>
 <YbeaX+FViak2mgHO@dt>
 <YbecS4Py2hAPBrTD@zn.tnic>
 <YbjYZtXlbRdUznUO@dt>
 <YbjsGHSUUwomjbpc@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbjsGHSUUwomjbpc@zn.tnic>
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e48e2eff-ea27-4d3d-ff8f-08d9bf5fe4fb
X-MS-TrafficTypeDiagnostic: SN6PR10MB2829:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB28297B4FFD609404E3780E08E6769@SN6PR10MB2829.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UEhJK/ywO7Oaie65KBTiK+qgp83vdNS2OOcKXw5aOTs3oCVh2lSQNE/pYrCRld8Qni7yeTopgeCxZJnxyE5OZGUIWvMiDBXSsMBbEUmY1wwwbO3l54n1T8GuqkBriLR0lEKuVfRTQGTb49XiOSqBDGFftkh9t2iU90bIphyMtUI+xrDjpfWViiBjbS+XRkQmKAF4Env7nBmwQ01n4Fq1kdls6Ln0EwBGhRQxddGwV11M6E8KFMXLieHVfUlKSzLaP/BAdVdv+kVO2RTTbcx7/00iQP1h+3XNWvcXqsjz2dn4RkwpHmTHPfon0vc7UvNjrp3mJiaxY1WYaZGJuiiJ65skLGO4dE3vGJEpNc6RKqWdccN0ufeCF2eJKursKbGClNf/ICVzaVhudlPQYiXqQ/5LJ1SBM5Wbtnw+pSBSBXk8Jt5AdU9KCu35PH63t53HJ1mrNjMYqJR4aG60DmmtK5RrYzBgtMWYhdnE8DDYP/xTCsKYgZnz67k2Y2/n1i9X+waiFfVJrVvBqs1XUeWb8drewzjAJCWhFGKHaAyukgg0ZuEyOK0w3AOpLxkg8Hb9kYNroWONgwgpYkn6vYOmB/vnWc0vo9ev0riyPoxSlxn9Dq5oLmQJ5btF1smgb1RU5EuC67GvetAWgk2iAo+wxgwwL956tcTm4i2fM/JA0tYxkoTrMv7GU7Z8qIil2xjfakIb6fK6U6xh9JhnLFtl1m2gOwUu1d8IYq3b7ZDOTCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(4326008)(966005)(4001150100001)(508600001)(54906003)(2906002)(8936002)(38100700002)(7406005)(6916009)(316002)(8676002)(86362001)(7416002)(6666004)(6486002)(33716001)(186003)(53546011)(26005)(6506007)(44832011)(6512007)(9686003)(66476007)(5660300002)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pJ+MZjtKmJ0fb5bCYmplvQIlBXkMMh/vUhnxYuC4u9M/HZWPER1YYvbbnYwI?=
 =?us-ascii?Q?v03sh79Y1t8+qtMeW+sG+VVMVnx3qvLvBpWVxeQy9ne4kynhQtjIyHg2OmHW?=
 =?us-ascii?Q?1n1ZvbR9GGrcS0KSUGXtsWvSU58xwFUrEdYvkv4Nnew01Qtncx3OSbFiY+uP?=
 =?us-ascii?Q?4s8h/zAmkhg8h0ZGPBxn3M5C2Q0IpuqjHV/XEsID/YhlP/sUY7mKD214SNJa?=
 =?us-ascii?Q?UGlEUxdnZ1ea33qYoqro0TEt/Mnj5LhJQ8mE66pE93WHnOSVj6lR1KbIpTpV?=
 =?us-ascii?Q?M+oCMppTemBSQ4crAFO9Gf32ufvwtjkVy3KvfEiIT1K+sDylKI4XvgvdFhF9?=
 =?us-ascii?Q?Ve5702ICKIeVrJxlk/ijQsLY8wdDHOu/Wypeoww6MN/spj6KuTVI1G0qIbjQ?=
 =?us-ascii?Q?GIWytQiQkvzCdy9uXddltSzEJof3qZ8xjt2R3bWnTbcNISKL6hzywFsL+87S?=
 =?us-ascii?Q?IwSyv7XqA0zqAJNKBdVXAHchYghkYMF5TrASjSb6zn3CCmd7Dbx1CDHutDxl?=
 =?us-ascii?Q?Zsqq4fluRzLUhAaDBPI59geKh7r68UW00mMyjnHE0NOAwtjEM4QSsSieMO3B?=
 =?us-ascii?Q?hTBfHQ7L+bCK4t/Cfa47mkjS4KZHP2B8Ft2R/fgXG0RRBkhXZMDMUzTGMEx4?=
 =?us-ascii?Q?fIWzVcnSseGzYsCVvJNpGTyxSZPUVEmayoTPa3TsugIz8I4xVSQOFr1e2b83?=
 =?us-ascii?Q?mNOUAdzz7SbqQa5zkAZWqbtiI18yDr70jJrWfWntYBLjwn9zDKSVriARDINS?=
 =?us-ascii?Q?hcZHHpiO5okDgaiNN18oRY9YrMyy7/ys+BuGpv958Xu9mjnnlNbZ6fMGPKxc?=
 =?us-ascii?Q?MuNci9+nnLf7OcrHFsFkmF44O9YiO/z4pwYoNvNqJ3M6DnBP70H+PDDmwhm6?=
 =?us-ascii?Q?lnT5CCd5c5gjkeM3JH5m5bXkyZRMxsMHJYns1jW7lCi9yKhs1C3PQsnVv61Z?=
 =?us-ascii?Q?zTekf0KKT5COETsIG0N3Zy+OGYesIUNogdaTggRLiB2wo1kV/NnjCtacTlx0?=
 =?us-ascii?Q?W39/xQQx1ge/wTmqoM5vlZxJqUMmkq/M3NqQplr/JuuauNNm9IutTOMlVQWf?=
 =?us-ascii?Q?eu6JWkWoDYoTd45wzyJUimxhT5vwr86vaDuJkOq5N9snpfGqJW/sIYtqniMG?=
 =?us-ascii?Q?OgzZJYG3s0g0fNxfyrRKDOQkKQ9yn1g+yQKN4/dy0WpBPMz3IvpUbd3BbY5y?=
 =?us-ascii?Q?mZxdcdfx0AB66Pdj6p1PqxEXra291w364xb02fYwmLLF22ba+ea4mQUFXwul?=
 =?us-ascii?Q?ERrrVM0ILJrMxrLrXHfjNxCUcnXvo2OJxnIZz92YamZNG5mLCRh9s1LQx7Zj?=
 =?us-ascii?Q?NkfoQjjOBLkg4Hjsqce3VPynO8pf3ek+5KfFjArO75ZD3LF8nFK5Ao6R/C25?=
 =?us-ascii?Q?rf40W0lGXtbJOUNEZPKJkVdErUpWGG3x1o42A4JYHc+D608qv5xrdlzAf4rE?=
 =?us-ascii?Q?9fxFD5ifIBdMypQlFYk9lWf7GOUXIFrKMqrlQalNZhMzJA+7eXKi9ixCNWsL?=
 =?us-ascii?Q?iXYbJY7mqxqS7HxQ8CqTbbY4QrTJw29QtEcMcS4+pRf+93goEYDUQjXVKbxl?=
 =?us-ascii?Q?8mPHwyMCn70W/+wl0g1h3GAUWWEnmL5WlunjURwmlM81bK2rmEVLApgb3wcc?=
 =?us-ascii?Q?KkraQp+mIlMse3M4IBmVAxe4pwdHpp5YM8XIRB7EegsNmXs6l27R96aGyVDV?=
 =?us-ascii?Q?UWrmpg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48e2eff-ea27-4d3d-ff8f-08d9bf5fe4fb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 00:14:43.5863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKyKk0s6+dAiH8LZdX/jY97ay7/lk/OjOOrREm+1T3yF4nJIkxPzvlHcR8aVczQYgBhnF+C/HPpYvZg/R6lkVnC9xj/N0CmTVg9fkd79LYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2829
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10198 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140126
X-Proofpoint-GUID: yonWYpZwDSCi7Fo_yvEdVtuwk3Q02U8g
X-Proofpoint-ORIG-GUID: yonWYpZwDSCi7Fo_yvEdVtuwk3Q02U8g
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-14 20:10:16 +0100, Borislav Petkov wrote:
> On Tue, Dec 14, 2021 at 11:46:14AM -0600, Venu Busireddy wrote:
> > What I am suggesting should not have anything to do with the boot stage
> > of the kernel.
> 
> I know exactly what you're suggesting.
> 
> > For example, both these functions call native_cpuid(), which is declared
> > as an inline function. I am merely suggesting to do something similar
> > to avoid the code duplication.
> 
> Try it yourself. If you can come up with something halfway readable and
> it builds, I'm willing to take a look.

Patch (to be applied on top of sev-snp-v8 branch of
https://github.com/AMDESE/linux.git) is attached at the end.

Here are a few things I did.

1. Moved all the common code that existed at the begining of
   sme_enable() and sev_enable() to an inline function named
   get_pagetable_bit_pos().
2. sme_enable() was using AMD_SME_BIT and AMD_SEV_BIT, whereas
   sev_enable() was dealing with raw bits. Moved those definitions to
   sev.h, and changed sev_enable() to use those definitions.
3. Make consistent use of BIT_ULL.

Venu


diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index c2bf99522e5e..b44d6b37796e 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -291,6 +291,7 @@ static void enforce_vmpl0(void)
 void sev_enable(struct boot_params *bp)
 {
 	unsigned int eax, ebx, ecx, edx;
+	unsigned long pt_bit_pos;	/* Pagetable bit position */
 	bool snp;
 
 	/*
@@ -299,26 +300,8 @@ void sev_enable(struct boot_params *bp)
 	 */
 	snp = snp_init(bp);
 
-	/* Check for the SME/SEV support leaf */
-	eax = 0x80000000;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	if (eax < 0x8000001f)
-		return;
-
-	/*
-	 * Check for the SME/SEV feature:
-	 *   CPUID Fn8000_001F[EAX]
-	 *   - Bit 0 - Secure Memory Encryption support
-	 *   - Bit 1 - Secure Encrypted Virtualization support
-	 *   CPUID Fn8000_001F[EBX]
-	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
-	 */
-	eax = 0x8000001f;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	/* Check whether SEV is supported */
-	if (!(eax & BIT(1))) {
+	/* Get the pagetable bit position if SEV is supported */
+	if ((get_pagetable_bit_pos(&pt_bit_pos, AMD_SEV_BIT)) < 0) {
 		if (snp)
 			error("SEV-SNP support indicated by CC blob, but not CPUID.");
 		return;
@@ -350,7 +333,7 @@ void sev_enable(struct boot_params *bp)
 	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
 		error("SEV-SNP supported indicated by CC blob, but not SEV status MSR.");
 
-	sme_me_mask = BIT_ULL(ebx & 0x3f);
+	sme_me_mask = BIT_ULL(pt_bit_pos);
 }
 
 /* Search for Confidential Computing blob in the EFI config table. */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2c5f12ae7d04..41b096f28d02 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -224,6 +224,43 @@ static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
 	    : "memory");
 }
 
+/*
+ * Returns the pagetable bit position in pt_bit_pos,
+ * iff the specified features are supported.
+ */
+static inline int get_pagetable_bit_pos(unsigned long *pt_bit_pos,
+					unsigned long features)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	/* Check for the SME/SEV support leaf */
+	eax = 0x80000000;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	if (eax < 0x8000001f)
+		return -1;
+
+	eax = 0x8000001f;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+
+	/* Check whether the specified features are supported.
+	 * SME/SEV features:
+	 *   CPUID Fn8000_001F[EAX]
+	 *   - Bit 0 - Secure Memory Encryption support
+	 *   - Bit 1 - Secure Encrypted Virtualization support
+	 */
+	if (!(eax & features))
+		return -1;
+
+	/*
+	 *   CPUID Fn8000_001F[EBX]
+	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
+	 */
+	*pt_bit_pos = (unsigned long)(ebx & 0x3f);
+	return 0;
+}
+
 #define native_cpuid_reg(reg)					\
 static inline unsigned int native_cpuid_##reg(unsigned int op)	\
 {								\
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 7a5934af9d47..1a2344362ec6 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -17,6 +17,9 @@
 #define GHCB_PROTOCOL_MAX	2ULL
 #define GHCB_DEFAULT_USAGE	0ULL
 
+#define AMD_SME_BIT		BIT(0)
+#define AMD_SEV_BIT		BIT(1)
+
 #define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }
 
 enum es_result {
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 2f723e106ed3..1ef50e969efd 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -508,38 +508,18 @@ void __init sme_enable(struct boot_params *bp)
 	unsigned long feature_mask;
 	bool active_by_default;
 	unsigned long me_mask;
+	unsigned long pt_bit_pos;	/* Pagetable bit position */
 	char buffer[16];
 	bool snp;
 	u64 msr;
 
 	snp = snp_init(bp);
 
-	/* Check for the SME/SEV support leaf */
-	eax = 0x80000000;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	if (eax < 0x8000001f)
+	/* Get the pagetable bit position if SEV or SME are supported */
+	if ((get_pagetable_bit_pos(&pt_bit_pos, AMD_SEV_BIT | AMD_SME_BIT)) < 0)
 		return;
 
-#define AMD_SME_BIT	BIT(0)
-#define AMD_SEV_BIT	BIT(1)
-
-	/*
-	 * Check for the SME/SEV feature:
-	 *   CPUID Fn8000_001F[EAX]
-	 *   - Bit 0 - Secure Memory Encryption support
-	 *   - Bit 1 - Secure Encrypted Virtualization support
-	 *   CPUID Fn8000_001F[EBX]
-	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
-	 */
-	eax = 0x8000001f;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	/* Check whether SEV or SME is supported */
-	if (!(eax & (AMD_SEV_BIT | AMD_SME_BIT)))
-		return;
-
-	me_mask = 1UL << (ebx & 0x3f);
+	me_mask = BIT_ULL(pt_bit_pos);
 
 	/* Check the SEV MSR whether SEV or SME is enabled */
 	sev_status   = __rdmsr(MSR_AMD64_SEV);
