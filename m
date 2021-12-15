Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3A2476144
	for <lists+linux-efi@lfdr.de>; Wed, 15 Dec 2021 19:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344061AbhLOS7U (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 13:59:20 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44004 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344060AbhLOS7T (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Dec 2021 13:59:19 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFIGgHW019434;
        Wed, 15 Dec 2021 18:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=u6VdDqLWNvaIqniODbEHgUV+KNjJT629iUGOqR31NZY=;
 b=mwfcm3NrQxYMYnpOM8o5A/tpYl4brQFbUojiUagaC1yr0bdGkqxGMDqsa05lX/zKzI/F
 8mLkZ7YMcEtX7UShm6206LVXo43U1DOaAGZt+86iUWDeiujGG6R+3nhkACdas9u66w8C
 hWG6AtK6/TOJLol9416QoxhPp0IZ15AIxQ6Ay4nkPuu8nvQmY7/MsNOEBrruSI+hlyEn
 0dsDZGfBRuPy2+BOBNgCYMHMoIEvpocJEYiYLr5/8cd/AWMSc9OykkXRGW3G00wkt8/q
 IrcpgFh4Bxg7tudoOYjHBm2z9eXBeP9gQkmf8inBej1U9liDw3AlIh3GMvL2fvFKQCsj 1A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykm58hr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 18:58:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BFIpjwQ022730;
        Wed, 15 Dec 2021 18:58:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3020.oracle.com with ESMTP id 3cvnescs3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 18:58:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bgqoeoeg0f1cdQZNicXS8CpCc0irWadABXCJC8cCxbWD0U3DI6Ju2LXgxZ8hWtZGX5zcGP/qqN4Z708GWaF2/rhPOONWTkBOsP9lUFMOI/CfRIIMjT1xs1FRzMqfqCeeRC3Tw6yaf4nWXHfkIbyUtbUUB7ZTLk5pVW1dqoQBM33Jm37giB+WmUBsJgZ0XnF2ZTbtHH1zu7kDtm4ZdDT1oRODXxbn4j9O1z6OYZ101eoLIOENNu8EDjkJ/U5+yZ0b1L+U3JtvXplbxJo77UMhjfBtzp7SkoFsMd8hL1hOpvwrBTvBKCwPY0EuEruuH69APznwzS0mdnuhzAP4Hh6e5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6VdDqLWNvaIqniODbEHgUV+KNjJT629iUGOqR31NZY=;
 b=Ega+IlxXKmoxRHRxYmQlnpvEhTGCv+6bwQJRtKr98KCdCtp7hC4yme8xN/lLp+i+/7lJT9S4FMjP0YXFvIreCGVE4Sjn23bIhVJDqGyE5eXhDp5XJnqeRon3HaTxn1gwKV0yUt0WGqCo/f3YxQ7mXrDjTu599TLFLYtREQpeaIHgFnwtMIoYt4YyrM6DxZj1xD+18AKb7wbkzqo+LP5Z36fpiGXd2Q2UrN/8geKL47kCg2icgrrK04VmaKaVKjEJAZkmBH3UgcpTqmXrCzZSj/QriqZ3rJ+WNiHq7diHHy9+bdYwscnP6wXWR2pPvcB8UEoLkI8dz+MvKT2H7W5vWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6VdDqLWNvaIqniODbEHgUV+KNjJT629iUGOqR31NZY=;
 b=lllbA/LYFmJ0bBGHap/I/GM+L6XEDcjWLdID7oHpnFBUeSDhtjq8wRlxYiw/bUylv0ePx6FZSO2JdCN1YEmSsSwj6S/JBLlVo8NByGKBJetWPAseL9UcxSDzKafiXKBRqpIKgjtt/CQD7Id+CcnVrgUjsudluXhKxduZ3+l71rI=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN6PR10MB2863.namprd10.prod.outlook.com (2603:10b6:805:d0::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 18:58:41 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 18:58:41 +0000
Date:   Wed, 15 Dec 2021 12:58:32 -0600
From:   Venu Busireddy <venu.busireddy@oracle.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 01/40] x86/compressed/64: detect/setup SEV/SME
 features earlier in boot
Message-ID: <Ybo62DbVK8tzwyDO@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-2-brijesh.singh@amd.com>
 <YbeaX+FViak2mgHO@dt>
 <YbecS4Py2hAPBrTD@zn.tnic>
 <YbjYZtXlbRdUznUO@dt>
 <YbjsGHSUUwomjbpc@zn.tnic>
 <YbkzaiC31/DzO5Da@dt>
 <b18655e3-3922-2b5d-0c35-1dcfef568e4d@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b18655e3-3922-2b5d-0c35-1dcfef568e4d@amd.com>
X-ClientProxiedBy: SA0PR12CA0027.namprd12.prod.outlook.com
 (2603:10b6:806:6f::32) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1f8424c-9be5-4c84-b880-08d9bffce8f1
X-MS-TrafficTypeDiagnostic: SN6PR10MB2863:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB28630F09A213AD51B74E4FEDE6769@SN6PR10MB2863.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULGQUAVN6qJvZSMid29QfiNCWqbHzONcOLIscTeCwJ6Fa+b72IG2pz5tmQnI/fnN/LhvJj/1pawjiB2Q5zFUGzXMFgzu4XX99WCwyqlUiYbRR1UxMkVe0pkZ/ZU3FqYejI9nVqahA5sGW4x1GH9wOcItmpJlCwPubEDftCowA4PyeqAVCUqBSerzYtS2kKtu5ISXDr1DDcfvnFZPWIh3t1SF5HDXSoxskArCApZNYEmy/xFHFZ0X6HfGa9a9BH7WBBlDxrg9pRtHHnkB+EKumaKz6P2NzSTG5jNdn1gevE1N0IhrZkwdz0ongLl0la8oIr3Tn2V1PxddyKdax0XRWcFsOhtDM/t90tJNTvYQPUyOs9NzM4ex4v7n89/D0MfIIfuh1eumarmq9ipv2yE66uwd4Zhgfr+KnHnFVlURw0snjWxhPB1tJR0bOzUFg5HUZUNr+XXUUNFHqQOqdg4Vd7Hdh2unh3WqXquGnHBEdxvlWXf78fFYSsu4OthDysyOzZHYI/FHGuzhr72CDzv8dNVekwfm8eh1j2SRqmem9GAvGCx3B/7Lnrw+t4jCbhLdXRvqYlf2CTzvlcablSAxSzsIYe8RlA8WOSFOJtxynx9vjgWiFtlhxw5aDpWlFds6vVd+miJ66b/WRXxWJPdilw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(8936002)(66946007)(53546011)(6916009)(38100700002)(6666004)(508600001)(8676002)(5660300002)(2906002)(86362001)(66476007)(83380400001)(6506007)(6486002)(6512007)(44832011)(7416002)(9686003)(186003)(7406005)(33716001)(316002)(26005)(66556008)(4326008)(4001150100001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JVbdacl/icC6ma52HFoomHtY7dCSndm1bNnFqDLziTh3wU8CCp0dBe6+NS08?=
 =?us-ascii?Q?Ku3SFCgJ2MRMtlGhgQ8k6fAq5s+zFMEBqGaO9NnP5+V7Dv743Vv6kgVtbs/K?=
 =?us-ascii?Q?/mMAXvL7uhKj18163Innma8ypacUR4DlcNzPuzRMPfn7LbHdviNKNkhd1eAy?=
 =?us-ascii?Q?h7SyE8e7edg/S4UwGd//SIaLQHNja/d1jtwGFBCGaeSJuY7depomMp2js7/X?=
 =?us-ascii?Q?yYVdZ+0ozZy2X+8GiJ2VuSs71hQyA2aACxMJ37YXM4PBqeNr9JGtU4ci+eHP?=
 =?us-ascii?Q?beFcWwvxXacBww58Mw3hSaMfr/ze+1ce0YK6hb9O76+0k/KcHXc/2uS3WkPw?=
 =?us-ascii?Q?0ArGOSooCdlnbQV/c4/uIHKdBIvjifDgcH5Z7ILorzFnyGUKpj9iGZgwp60Z?=
 =?us-ascii?Q?UMf6rSh/JJ+MKJu8c2OSfg9lJsrtR3s0JOVfGLB4OaD2E6ER93T86GfSNGdq?=
 =?us-ascii?Q?33KzvK2lAZCZwVzwMbYImdyw2L9Yc06q5MsXlLzxTgZV56C3kx5Tmg7jU+IX?=
 =?us-ascii?Q?OU8yWmth3IniYEUMvfj+MT2NXeYeaRgjFcofGw1ZxAGrWfg0JvYd4/ml76pP?=
 =?us-ascii?Q?bFH2Y5VfsqIPJn9iMHJVRXNjy1pw54Jql42pLZXDYHqeh811XRxe9/an+EHb?=
 =?us-ascii?Q?JFx/0bpsSHEN87xkAlERLA5nc/9Esunx2N245+cufQleZx7krB3jG1onMDZV?=
 =?us-ascii?Q?38kZQGLUVrINiwrUyOMgSafZZZ/LbaIB/OoDY5nbqaSaOL//MiKCBLJanQjT?=
 =?us-ascii?Q?XJfUd0SX3FKLOdKPDUSU83sA96ns4dUgnm/0aeuvxyauCGl22DQGd2eBnMbe?=
 =?us-ascii?Q?PvcqGun/OUbuQVETjoQcWA5FtY09PCafF5pSzzwms67mS2zxAhw4ZwRExndL?=
 =?us-ascii?Q?0hF5ggOcAmxkf2TrCgseDw4vlsWydVaV4tcBuLtxMswO6X/QpMz9QG9n+DBd?=
 =?us-ascii?Q?V1tb3af762YczCT9N6L+g6zgxYvvS+yo3i3yxE3G61W+uU0pVdxdQbnZY4rd?=
 =?us-ascii?Q?4sBovRwUqzBqo8jyFT3L5SnMXcePjWtUg8dUsom835CbjKCUdyQ6ZS3B2y9v?=
 =?us-ascii?Q?q7BGKfowuJ/Y1L86bHo/x9fhrm1A1V2dFhV30cRHrKG/8VcF7LIbiJZyfyuQ?=
 =?us-ascii?Q?UxB6TnaVVIhW2pzrQL8X3PqgLYOqqJ2nIu3vKkBz8Ee4NoaRW8qdtVFb/+ef?=
 =?us-ascii?Q?3QRrAUWwnIU4jxlvGFvbpyPvuRgfsv8VHVGR6PiSE27lcgP1X5j5Bwd2Z8eX?=
 =?us-ascii?Q?qd3neo8Llsbe9k8cy1aYX/F2OE9Re2ezHu9Qd0FOZ//pinHNAAr/FUOr0Zl+?=
 =?us-ascii?Q?Tiu/hCD7gOmuT7ce8DbNQm8glerUG4h1SuihSlolfKaW1aae/c6pGB8dqUiZ?=
 =?us-ascii?Q?k3xs4fnq6AW1m0KcMtLCaqrC1cbhIbxPCmjqJT8Tx0Zan31ggqbjWxi+0HKz?=
 =?us-ascii?Q?ZpZDox3Y+fCbBaxHaVtyZ74iItP0Qe7vzqzKakcMJmuAeBx/ZZJORNEn0pXj?=
 =?us-ascii?Q?xhNUyt0welFQ8OL4Yn09ytAc3FmsrZtBDG4oLxPeBTS+VnpnAIQK3xxrpF5v?=
 =?us-ascii?Q?sf1vEj59sAglQjRQIKAgx1Wm7ZOXtjuNb4ebEQ1pl1Plu5gIvfoZ3SMQTa/7?=
 =?us-ascii?Q?LvmSB6g6/4Uo1MmA4IiAlwwTJfLVdniEb0WGDcosqjw3ej3fncROb4xu2ilD?=
 =?us-ascii?Q?HBIeBw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f8424c-9be5-4c84-b880-08d9bffce8f1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 18:58:41.2284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YeXZtsfhyECuSmqa77CBIUgsXV01M71qVg+Ua1yDE5psbgrs9XcdnqAN56bKDZNMnynObyNrfbsxfCSviQ6ZfdThUWksC8xnczea5gs8IE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2863
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112150104
X-Proofpoint-GUID: 0MIVeoeKkw3c65N3BaAi7I4_Oy_4bcwT
X-Proofpoint-ORIG-GUID: 0MIVeoeKkw3c65N3BaAi7I4_Oy_4bcwT
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-15 08:43:23 -0600, Tom Lendacky wrote:
> 
> I'm not a fan of this name. You are specifically returning the encryption
> bit position but using a very generic name of get_pagetable_bit_pos() in a
> very common header file. Maybe something more like get_me_bit() and move the
> function to an existing SEV header file.
> 
> Also, this can probably just return an unsigned int that will be either 0 or
> the bit position, right?  Then the check above can be for a zero value,
> e.g.:
> 
> 	me_bit = get_me_bit();
> 	if (!me_bit) {
> 
> 	...
> 
> 	sme_me_mask = BIT_ULL(me_bit);
> 
> That should work below, too, but you'll need to verify that.
> 

Implemented the changes as you suggested. Patch attached below. Will
submit another if we reach a different consensus.

Venu

---
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 7a5934af9d47..f0d5a00e490d 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -17,6 +17,45 @@
 #define GHCB_PROTOCOL_MAX	2ULL
 #define GHCB_DEFAULT_USAGE	0ULL
 
+#define AMD_SME_BIT		BIT(0)
+#define AMD_SEV_BIT		BIT(1)
+
+/*
+ * Returns the memory encryption bit position,
+ * if the specified features are supported.
+ * Returns 0, otherwise.
+ */
+static inline unsigned int get_me_bit_pos(unsigned long features)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	/* Check for the SME/SEV support leaf */
+	eax = 0x80000000;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	if (eax < 0x8000001f)
+		return 0;
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
+		return 0;
+
+	/*
+	 *   CPUID Fn8000_001F[EBX]
+	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
+	 */
+	return ebx & 0x3f;
+}
+
 #define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }
 
 enum es_result {
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index c2bf99522e5e..838c383f102b 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -291,6 +291,7 @@ static void enforce_vmpl0(void)
 void sev_enable(struct boot_params *bp)
 {
 	unsigned int eax, ebx, ecx, edx;
+	unsigned int me_bit_pos;
 	bool snp;
 
 	/*
@@ -299,26 +300,9 @@ void sev_enable(struct boot_params *bp)
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
+	/* Get the memory encryption bit position if SEV is supported */
+	me_bit_pos = get_me_bit_pos(AMD_SEV_BIT);
+	if (!me_bit_pos) {
 		if (snp)
 			error("SEV-SNP support indicated by CC blob, but not CPUID.");
 		return;
@@ -350,7 +334,7 @@ void sev_enable(struct boot_params *bp)
 	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
 		error("SEV-SNP supported indicated by CC blob, but not SEV status MSR.");
 
-	sme_me_mask = BIT_ULL(ebx & 0x3f);
+	sme_me_mask = BIT_ULL(me_bit_pos);
 }
 
 /* Search for Confidential Computing blob in the EFI config table. */
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 2f723e106ed3..57bc77382288 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -508,38 +508,19 @@ void __init sme_enable(struct boot_params *bp)
 	unsigned long feature_mask;
 	bool active_by_default;
 	unsigned long me_mask;
+	unsigned int me_bit_pos;
 	char buffer[16];
 	bool snp;
 	u64 msr;
 
 	snp = snp_init(bp);
 
-	/* Check for the SME/SEV support leaf */
-	eax = 0x80000000;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	if (eax < 0x8000001f)
+	/* Get the memory encryption bit position if SEV or SME are supported */
+	me_bit_pos = get_me_bit_pos(AMD_SEV_BIT | AMD_SME_BIT);
+	if (!me_bit_pos)
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
+	me_mask = BIT_ULL(me_bit_pos);
 
 	/* Check the SEV MSR whether SEV or SME is enabled */
 	sev_status   = __rdmsr(MSR_AMD64_SEV);
