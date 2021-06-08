Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FDC39FB55
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jun 2021 17:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbhFHP6m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Jun 2021 11:58:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36240 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhFHP6l (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Jun 2021 11:58:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 158FsCPS180401;
        Tue, 8 Jun 2021 15:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=epx4g6O7+tisD9uK6B+ckv+e2nLXkSq2Y9ex3ZK36Zw=;
 b=CGIOalGDOQwg8BIx6igKoixgyVyfiQVDYtB9iPQppUnSqkWFPGXv7jxS3qDe1YQ/2B3/
 h19rnAba33GDOgFKwn3uaLDTukzJ9DQxXloR+XDf5i14fBwTH5bhzLJxDAG19sprBNrn
 WZprPBNVAikk2q0blc7IDOsMme6Ua9gCXJGbtXC+/ZTw0l5OeMhwNroWCvIGWmrBmOWt
 OQwScTxY/lRRZQly7Sz9zR9hYQXSCCtYyx4vhgcuLxWrVx6GX4jU7Q/erb0KTgPxFfv4
 gxWEW6wcetKJHAn+nDNaidKAqUBrpJ2yrqHg5rc62+NqnT4uEyLnkR6XX/u/gDYfOlo5 mA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3900ps6k54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 15:55:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 158FkqHc137844;
        Tue, 8 Jun 2021 15:55:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3030.oracle.com with ESMTP id 38yyaayt0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 15:55:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6ly4pXHhtIRGK3URkgFl8Z+5OY1Xd5xDjm+WQ+9Ii4RNJuOOpgZg1+uZChunttd9UlV7T6fZQBmCeKmNjk7BiMNli9E66j+DGkiALFL67XSUoCha50TN4PGBTW1EG/fp/y7CXIP7xiqhrHDwSCEkhVOQ9TH0BQJWqTVTj0iFxpIxk82fkfr5utRsn3sVy5Iwruy0SvqgsWEsAEa88dj1uyLclq4FFsTmLUko3MCEbW91oDew6OQfDDCs6czaPNpM5lYj20zFrHya+NtCwRWYoiwk7LrX2TcWiAPGhsHl2TQzTwawaBGALB1k5Vj969lZG/vFMAVOHi9Sj5iWVIcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epx4g6O7+tisD9uK6B+ckv+e2nLXkSq2Y9ex3ZK36Zw=;
 b=VE7+UQESPrBAabLaz7hy0S71xvVyjpXhvuBgB2uhgHmbPkaFkURMHHpPCX6klZCmtE5gHu9yNsK9T66Uc+EPfOV0zIqav9TjhZ+eFw/eR/S6odYi30tT3+0P0QKnO7yuPG5mJeR32HD07pJUW5w/75HRKLxWfwNac2Hr/efSJY3dQLN1nreiLz3yruDznjEdr2qgaPkk3f4SPFTWUzYqrH2bqXQgJO0q7pjffcac8gSSHJPfihD6ucXufmZ4i9kA/BS/t7M2u0W8vSp1Jv3GYiC596ZrPUnh8mMMdklUDh73Ib5DEUV9bngH1K/HUTM9c0MwCi1Ru7zPRus80g48QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epx4g6O7+tisD9uK6B+ckv+e2nLXkSq2Y9ex3ZK36Zw=;
 b=D6EXJ9E6V1y1U0rYLlNYBNtDO/T0xeOKIo7yg4Dj7hm+JomJXUEAm5nCgk2rFo8IroP0FFN/7OYNUGMNDNx7HdA4r7H9mu739hHMcQMtu4Z4ztt/ELBqdlMkh/Ake7ZFgPEiTZeQRDkoTWwGOiPl1Wc7VFRawUCYQr5cnrNjRdw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SA2PR10MB4537.namprd10.prod.outlook.com (2603:10b6:806:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 15:55:05 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::945d:d394:f2ad:2c97]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::945d:d394:f2ad:2c97%7]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 15:55:05 +0000
Date:   Tue, 8 Jun 2021 10:54:58 -0500
From:   Venu Busireddy <venu.busireddy@oracle.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 01/22] x86/sev: shorten GHCB terminate macro
 names
Message-ID: <YL+S0r0pgS5wNAJK@dt>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-2-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602140416.23573-2-brijesh.singh@amd.com>
X-Originating-IP: [138.3.201.62]
X-ClientProxiedBy: SN2PR01CA0009.prod.exchangelabs.com (2603:10b6:804:2::19)
 To SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dt (138.3.201.62) by SN2PR01CA0009.prod.exchangelabs.com (2603:10b6:804:2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend Transport; Tue, 8 Jun 2021 15:55:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2660c52-80a3-4953-b825-08d92a95c86e
X-MS-TrafficTypeDiagnostic: SA2PR10MB4537:
X-Microsoft-Antispam-PRVS: <SA2PR10MB4537531D8511565B116D5C49E6379@SA2PR10MB4537.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +AIGgROPwv033P8PgOKuyB29wxAGgVwbSOR1fzTXcSsLK+587V8rj0+AmqI7iCuBGGLz7RjF1gQTX1ixqcgQ9wVuN3gaeBwo2Y8XvOtxv7u68I4uO8TVUsqNbNY05J+DMS3/eaCdQbli51HKP0/Gxf4XuThge4gxkxM0tOnbTc1jArpbXY6PuQa9cktbpZsn7NaFWHamE8JLjNGzK2RM0dRNQbgcFBhLqTU+m0vqhZUch0k3yMSKQhVy/vGQ3A8ViwJX0WtH8zfdJCQ3URiTq+cjRjFWYUQvrMCOcEQG0Fuq3VXqbCUdhswWdo4f8Tx+sgG6QKSF9UbQDUwA4eXlBI+qcsMCCd5a2ZvBvTFNckUNvIndXQRbdPElerKIcEWWAUg8RfGfYANJj24LDaPHT2yUryg84c1xxliwLBuBjHQqIiQ5oTrVwr6OcOzk4qIDPR2zfA8dC/UqFGAHedWdOCUUaxsAFnoNomMlPCuFLt0WB0O5FEgc8veCLv9e/fpAVgUKlyNxo50h19GEqO2QSUpmUh3n3LVT6VEUsw0Gisgywy+vj/6qGsbmxMpHOPZSnpdiSyK6qW5KLzJOG+DrYHSY0DdYXQ0SPRh3zC8gXtlpfjFn+kdoxt170GDup5/MsuaQK/PvJ3SH3hqFNwxcW1/IZRkRtH59sdMAFNvxGg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(376002)(346002)(39860400002)(478600001)(26005)(7416002)(8936002)(4326008)(83380400001)(2906002)(44832011)(9576002)(55016002)(9686003)(54906003)(316002)(6666004)(86362001)(186003)(66946007)(66556008)(66476007)(956004)(6916009)(53546011)(52116002)(16526019)(38350700002)(8676002)(6496006)(5660300002)(38100700002)(33716001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wFbRCyUyd+MJBp+iYd81QY8IULW/B26FDkvinnpj3y+kwDudWmEGJdE4NI/g?=
 =?us-ascii?Q?z8RtXW5LpLCAcQrXoVN+zjuGj/jeIkDi8N+i5+V0Uvb4q5GtViD3j+8E8McQ?=
 =?us-ascii?Q?/asq3mkRuDWNYpElgjBxMyk3VEJvAVvkyvphGj+lRCC1WjNJDThTmXjLaelm?=
 =?us-ascii?Q?mNRX126tAqH1HKWrlEK+vnufqJIHuH8rTRE5yiHZhUfR1Dg4KR7qWcEnZGI+?=
 =?us-ascii?Q?c1M9LlSfw+l+5UzsUdc1ysrO/a46IqvoR23Q9BzxAG7zMGUW1GvZVMd3FeDt?=
 =?us-ascii?Q?Ipl081V6STKQ0Z6bGpfH+K311HV7DbY0XkBnvfU2L0pUc/T1pV/oPoso5lOi?=
 =?us-ascii?Q?9wdFfnfp0Mlu7hTS3d1EDfipA5jbJB40LBwoaACEPYdAk/gA9kN2PnIRtgGT?=
 =?us-ascii?Q?xdpfWwDWseE7JHyBT7UN5UhARqvWDBhssndVzsKd/3MA3v9nycp2PqfN4yVh?=
 =?us-ascii?Q?EJYE73wsnkqfz/pr8vtULs0bFxbo2k6dIhLy1Yt19dRutt8QKE1prLgEFIRk?=
 =?us-ascii?Q?yHU01IvE3O09R8yJ5TquNum/Axwetx1Xve0SWUdgztYxQS5Aa/nQ2GGnStp6?=
 =?us-ascii?Q?jFtqUOqL6tYJCQ8RWI+dsWpgsehrYSwrJexVV7m+WehHGZknpoi/RsEgK3Sc?=
 =?us-ascii?Q?YPjtQl4jwWUxULP0X6Nnqeb1h78FA/WZ4t1hfBdJUmD1hVRZgv0cL0EwdyJ/?=
 =?us-ascii?Q?VI+28aoWRRZS+UjcdqmBygK2wK3s9glbpBpLq+NnqSMlaroG7uUMg3X9LFVN?=
 =?us-ascii?Q?dGohxNv53s62Z2ofijZb/YRFnve8yy08yVh0u3Orp65BJ0EzeGnhdVkJvqE9?=
 =?us-ascii?Q?S2Pz1/2Q9XJ73Mn0UY1Wbzcwvl8oL9qKj3xRvWJFEAoTR9eQn0/67Cqgy2Fx?=
 =?us-ascii?Q?ZTKd4i60msnnc8wyx7eFfsM2EIP6IQLjXMFIWNZ0iC07cANHpT1DkYTOZB5+?=
 =?us-ascii?Q?zTNXG7/kKK8DUepEBcOskTFl6kC2Rl40/VZlucRPClD5jO/YSTh0JcCEvqy5?=
 =?us-ascii?Q?74vb7ZLkNGJhodQQk7HhixNo3vjFMog6yk84YPyOgmzHitVzSbM2PW9koC30?=
 =?us-ascii?Q?FRNovC7oiIIQvGMt7QkzPOHuX1bUkAIzlLyewFdEaSTWeOZWBbVVaWUMgmJk?=
 =?us-ascii?Q?imtPy80BvVIJJW0un8h+Qz7cSmgX1Vfpv0/pq5ikvE/tyASRwOQVj0KX9QlS?=
 =?us-ascii?Q?aWZA5YPt3nVjCUN0A0iJwlovBuCNHMCfGFC9zQCohtSyac3Hf8d4xm8Bpoub?=
 =?us-ascii?Q?5DYM0EH/9Y9eg/IkrMlnWrjSICaOZGMiD2yuphYSGxfULI50ICEIQ1UzaEAc?=
 =?us-ascii?Q?v399Ll8x9c94hW4mekUzkrnC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2660c52-80a3-4953-b825-08d92a95c86e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 15:55:05.2288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzALlWomC6a7vmCjle5AL+wx8vlrpWdRSdAOMi9xQXN3d/o03mRqTLUMD1oysctusZZ+MhwMa+g7e7np3+FmTE2IZKvVGdynpyg5u6Cu5SU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4537
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106080101
X-Proofpoint-GUID: -kOWVnw1_vMz-TvFgMg3xjZcmuHpRWYs
X-Proofpoint-ORIG-GUID: -kOWVnw1_vMz-TvFgMg3xjZcmuHpRWYs
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080102
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-06-02 09:03:55 -0500, Brijesh Singh wrote:
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>

> ---
>  arch/x86/boot/compressed/sev.c    | 6 +++---
>  arch/x86/include/asm/sev-common.h | 4 ++--
>  arch/x86/kernel/sev-shared.c      | 2 +-
>  arch/x86/kernel/sev.c             | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 670e998fe930..28bcf04c022e 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -122,7 +122,7 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
>  static bool early_setup_sev_es(void)
>  {
>  	if (!sev_es_negotiate_protocol())
> -		sev_es_terminate(GHCB_SEV_ES_REASON_PROTOCOL_UNSUPPORTED);
> +		sev_es_terminate(GHCB_SEV_ES_PROT_UNSUPPORTED);
>  
>  	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
>  		return false;
> @@ -175,7 +175,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
>  	enum es_result result;
>  
>  	if (!boot_ghcb && !early_setup_sev_es())
> -		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
> +		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
>  
>  	vc_ghcb_invalidate(boot_ghcb);
>  	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
> @@ -202,5 +202,5 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
>  	if (result == ES_OK)
>  		vc_finish_insn(&ctxt);
>  	else if (result != ES_RETRY)
> -		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
> +		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
>  }
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index 629c3df243f0..11b7d9cea775 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -54,8 +54,8 @@
>  	(((((u64)reason_set) &  GHCB_MSR_TERM_REASON_SET_MASK) << GHCB_MSR_TERM_REASON_SET_POS) | \
>  	((((u64)reason_val) & GHCB_MSR_TERM_REASON_MASK) << GHCB_MSR_TERM_REASON_POS))
>  
> -#define GHCB_SEV_ES_REASON_GENERAL_REQUEST	0
> -#define GHCB_SEV_ES_REASON_PROTOCOL_UNSUPPORTED	1
> +#define GHCB_SEV_ES_GEN_REQ		0
> +#define GHCB_SEV_ES_PROT_UNSUPPORTED	1
>  
>  #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
>  
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 6ec8b3bfd76e..14198075ff8b 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -207,7 +207,7 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
>  
>  fail:
>  	/* Terminate the guest */
> -	sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
> +	sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
>  }
>  
>  static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 9578c82832aa..460717e3f72d 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -1383,7 +1383,7 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
>  		show_regs(regs);
>  
>  		/* Ask hypervisor to sev_es_terminate */
> -		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
> +		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
>  
>  		/* If that fails and we get here - just panic */
>  		panic("Returned from Terminate-Request to Hypervisor\n");
> @@ -1416,7 +1416,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
>  
>  	/* Do initial setup or terminate the guest */
>  	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
> -		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
> +		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
>  
>  	vc_ghcb_invalidate(boot_ghcb);
>  
> -- 
> 2.17.1
> 
