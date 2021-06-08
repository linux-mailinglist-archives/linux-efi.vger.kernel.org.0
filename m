Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A91339FB95
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jun 2021 18:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhFHQDO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Jun 2021 12:03:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37836 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbhFHQDN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Jun 2021 12:03:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 158FsgQY180978;
        Tue, 8 Jun 2021 15:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=iuRSOnzlxMncfkC/Z1egDaaIWTzvZYz/SWJbTvUgQR8=;
 b=HMZgLctPt8H3n0lkJpbMGfxjf0L5p2gagFRHsw7S8JDXvFVk/hVs9CN9h2psTgtPWOJb
 pQvOUJmyhEQ9dIqRCMPPKKRYcX1fDmg/Chz6E321sCLgBMspgxEfOoeP/Yr8tECs1D+v
 alhcz/aJz/BlPcJYqKQP6Rw0TlacO/ua392tucAQc+C8kk0+JiWx7uXmtSYLLga1opHj
 lLI4A0SrCV6UjERZIXgUE6jYAorRFbLiMPkdH0LqB4PFW9kHllmPS2KA/Gx6x/jmwNvE
 3OOu1Fm+vBkWjUz2IPNkRSzywidafgQ+WLAbnXzHO8MHoGoydYI9zG22qZvlA8Bzm5Ea 3g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3900ps6kgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 15:59:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 158Fuukw168256;
        Tue, 8 Jun 2021 15:59:50 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2174.outbound.protection.outlook.com [104.47.73.174])
        by aserp3030.oracle.com with ESMTP id 38yyaayvdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 15:59:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7h5PF0nqCeGTEfDxtbQGP/CJ84Kl7Zudji6lC2cDYIlz1BAnCxIi4s8x7+Tf8ifFuMO5/5uDxkiq5Us3VZLub4F/n8ku4Y+WE6LzLJ5mmOJetGKTjz4Cec7K4By+rwetNsuv7Xj3DwvvdgMUPvkzJL3zdzAOkfarwXavkh5HHaTNlM4o0GUjX4Ez4yxkXO/KUkjZIztOZeNHyUvphB0mjCeZmC0bZRrW40Sd77eN1ifuL2jLeS+d6aCug3YLj14/LlCWxsnS8OGceHs/h8rJ5uuu03tHqD9BDYLiTembIdJcBkn21/CzELiK3PM/oXPLxmB8ZZOsTlVWQrVBrWG4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuRSOnzlxMncfkC/Z1egDaaIWTzvZYz/SWJbTvUgQR8=;
 b=Ln/PZL8HQpgz9vC/wzQ4AWJB6pgy+IsTKxpFLyVsZvvUh7BgQU/woWMtH3M96BzmZgb2dD5l/6Sv0qQFpi2QE3iHU2pol2DvmH5tfZbG7LWo2AI7Zh5EcynUHjfNZ6GX5WEahQFa+bMc25Ck+2n6ChVZuRaQ5Q11CcKpcf6VpaYMHr8pgY6VmLbwUx5yJc+tzZen4OJLL/+wW1qU7+zJOmoJ0V9sSpAiUeEWlEAM6s4aNNNOIKRTJ29ZszTFMKiMIRGYjc+YeOYQRMm+Axo2T6f4IKqDJpBP2uuGQV4/sGeUqC2Qe92l2iqouy0Tn+NUh5rjAOTmeryCqhkJEQtqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuRSOnzlxMncfkC/Z1egDaaIWTzvZYz/SWJbTvUgQR8=;
 b=Rbe4G13Ld5JKXw1rHBfNhxDN5rF0TqUj0O9dlXgC57Xc97QoJOg2vb84nK0EZmdlishSNOQkxEbieVxsadI3upg4MLEp/NZo2Z+veMC7ffm8qfgu+bmReI9AamEB4qaHeIHnNQU8vBEUBNhgeUFEdudxN/8HkDg+hd4s7y1b/Mk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN6PR10MB2573.namprd10.prod.outlook.com (2603:10b6:805:48::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Tue, 8 Jun
 2021 15:59:47 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::945d:d394:f2ad:2c97]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::945d:d394:f2ad:2c97%7]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 15:59:47 +0000
Date:   Tue, 8 Jun 2021 10:59:41 -0500
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
Subject: Re: [PATCH Part1 RFC v3 02/22] x86/sev: Define the Linux specific
 guest termination reasons
Message-ID: <YL+T7X/417sQAUUA@dt>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-3-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602140416.23573-3-brijesh.singh@amd.com>
X-Originating-IP: [138.3.201.62]
X-ClientProxiedBy: SA0PR11CA0091.namprd11.prod.outlook.com
 (2603:10b6:806:d1::6) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dt (138.3.201.62) by SA0PR11CA0091.namprd11.prod.outlook.com (2603:10b6:806:d1::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 15:59:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e64237e5-cc68-40a0-f50b-08d92a96709d
X-MS-TrafficTypeDiagnostic: SN6PR10MB2573:
X-Microsoft-Antispam-PRVS: <SN6PR10MB25735CEF1D8A6FA06D72E9CAE6379@SN6PR10MB2573.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1bALFRZDCokPQaKqe5JFzo/iFss4bwwo9Dn4j+Ohk1OgKI1smBgasPgCTWdP7AQpEcvc1T5E++1x9feWtqMN/oj5Ms5Ffauuwx3t4aekbgObzZmwAWXo2WILt/w8R6vPi3p0g4w6vyW60RkqT/Q+mmiC9/vPSm/yJOS3dQoNAoxVXHz8TXMRGajtAQWl9s2W8Q1T1FlJIEh8blMyuctMalgkkzueW0UrND8k3R6W1jpSz8MYLqVyyUiFkW3gOzFFLgNhe/TgP4/mvgy2ZVIOikzA2PsoVMSZmhMqOokYeOfsJqdX+cdorXFoMAytXngJ5LzZlloXMwoBSxXw7YGrIq0N4G0S3vXOeqFXacnVbOwdfxBBzb5LFjQ3IINhYyHm7YzXIFIfn6MVXjuGDFG0n3TW7ES3BFk/VyTKNCfJJESufoaq2ZFvvpybWAuFDJgx2uncoZebVogbojvv1EcFrL5oXkRjlG6vRHDXW/urZoT0eV3N1nyBevYSigHTp5JfewfRzKpsBAitnHwipTpvil2okYbs/Mzye/0CmBXao0TvbgpTEgYG8NA4LbO927UuR6RA/mWfrUTtL4kedIvQulMbSJXKjOyk1ZT5Z1CXwFGd2MInJmPmRSTBg9ON4IF4Q2JKgI610Z7TpYuBbxAaQB5z7THvLk+WvxjAjTAdOCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(376002)(346002)(396003)(33716001)(7416002)(956004)(478600001)(38100700002)(6916009)(83380400001)(186003)(54906003)(6666004)(16526019)(2906002)(38350700002)(86362001)(66476007)(66946007)(55016002)(9686003)(53546011)(6496006)(52116002)(316002)(44832011)(26005)(5660300002)(4326008)(9576002)(66556008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XgpA9a1tn9AB5LfTT77MukPJo4LDmsGYBi8/4xvQ/w0WXe9KKBzd7BmUTTyM?=
 =?us-ascii?Q?SuhfZ5aSpAebXD1uQMm1ahNUWYnKg1+TMIVXuMv3e8p84iCvs+jk9GV3FXsQ?=
 =?us-ascii?Q?NfrdfoDa4LQWg7mBrryMG9zkrNmUMNmOAfsQGxgmELJaKKXjXymLMyCNtpEK?=
 =?us-ascii?Q?ILlsazNi+OLAb+wYifVD30ME0vZMTbZprYtZp8r7qQlpln/8QkcLyq0tzIfi?=
 =?us-ascii?Q?lzmhlhsbstMrk/fGchYU6W3ltO9V23r09T/2HbIHuWdD8DoyyJQAd6/t7+8O?=
 =?us-ascii?Q?E+zldVmrj0NwRfj4igxepgzI/crK3V3yp/D5HVSXT9jiPVpjjCBu49OjlBuK?=
 =?us-ascii?Q?ArV3L4ljcKYxR1yEPUuvzh2ro3ZWLZjxKB2OuvvP/QcpO0XjWR4P/an27KVd?=
 =?us-ascii?Q?CyTjjlnb1Eat2wc4m0h0OLU13PrPEawo7iZBmfhyk+UDdIwP+Cy9ImofM3K3?=
 =?us-ascii?Q?Qvmiy2ZFYCG3XkQ+kET5jF4S8XJYMmIxK4Iyi4JBSBhrPC6K7xasJY3Kch7t?=
 =?us-ascii?Q?CI4xvYNy4eJgBglnVivAiU+JOXSi4upQYR8UnKTYXp1UEhEzUC+Rlst18SmQ?=
 =?us-ascii?Q?Zxtk6JHNw07d409MxZtrydf7r7GOOT35J756pBw/QbBvBVZlYDEv8n+lQKH3?=
 =?us-ascii?Q?RlqeANC0W/0fQN9OFTGkS0UdMQx7ZnzNVYo0VpQ8BucFV4H/TIQ1A6la29Tz?=
 =?us-ascii?Q?BPRu1aCjDyrb2ei/oXll/8jJKPmCIfkytfvOgpT3hC95CsyYyXkvVQHeCENz?=
 =?us-ascii?Q?JX7z61IdusEnlDcEZCGwCSp91pK9vT8bmxm9vCfFJ/EB13SyuulB5gCfzsDe?=
 =?us-ascii?Q?04+c0yTwisaPcrIZYPAwTL1tWyUnfgNB/UIdZZabbJ7yZMCrZ+5K3iZO9u9R?=
 =?us-ascii?Q?C1faKZ5+pcpevJcT7Dq8FsyBn314p8zNdhHPF9pdD1jeHJUqcCfLm/Jk9AYj?=
 =?us-ascii?Q?hDNJ0keIWipGBA9/a5m2akFNz+8OoJpvUP3uGyMVwqL5ICYCbKHWQOAdPwQ3?=
 =?us-ascii?Q?QT4ll+E+nh4YcvchfFXMFNaHZrAH0669KepnqTsF8pYuyWagmjvwqjprskc5?=
 =?us-ascii?Q?qn8/CSDsERpqNVqt7LwSg/UWUhjo5C/wyMBQ7PFLIxcAGOb9fG801s02beIv?=
 =?us-ascii?Q?6O/Q5zkDyFIllbhQXanDvw7hms/aetLffgGSo2fWw82vipbYiAIeX4mFAjYM?=
 =?us-ascii?Q?wtZ+8KFaW3vnlK58/7a3uMt+0jFNhL1vM2YI6AQ4kJqxqVIhkclj+PND7s4H?=
 =?us-ascii?Q?OS4VmiTy5h7PWsu5/9qoteAMZLemV2nfWKDLfMrXICD12HDjQbP6RQuz8FhG?=
 =?us-ascii?Q?wTSzu228aRTrhe4V1AG+whL0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64237e5-cc68-40a0-f50b-08d92a96709d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 15:59:47.3806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QlzzpUTnnYb3kNGccdJX8l+93QrNFKzF9D5ZW1ncCS5cy4fklsfllzqf3JR0K76061p/FmgjUVHGnCiBvaTbWoY1jWy0nzgO05V0f3e6CL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2573
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106080102
X-Proofpoint-GUID: Y8_h_9ZbEUKndziXEMS3c_iHRtVoL-Kp
X-Proofpoint-ORIG-GUID: Y8_h_9ZbEUKndziXEMS3c_iHRtVoL-Kp
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080102
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-06-02 09:03:56 -0500, Brijesh Singh wrote:
> GHCB specification defines the reason code for reason set 0. The reason
> codes defined in the set 0 do not cover all possible causes for a guest
> to request termination.
> 
> The reason set 1 to 255 is reserved for the vendor-specific codes.
> Reseve the reason set 1 for the Linux guest. Define an error codes for
> reason set 1.
> 
> While at it, change the sev_es_terminate() to accept the reason set
> parameter.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/boot/compressed/sev.c    | 6 +++---
>  arch/x86/include/asm/sev-common.h | 5 +++++
>  arch/x86/kernel/sev-shared.c      | 6 +++---
>  arch/x86/kernel/sev.c             | 4 ++--
>  4 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 28bcf04c022e..87621f4e4703 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -122,7 +122,7 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
>  static bool early_setup_sev_es(void)
>  {
>  	if (!sev_es_negotiate_protocol())
> -		sev_es_terminate(GHCB_SEV_ES_PROT_UNSUPPORTED);
> +		sev_es_terminate(0, GHCB_SEV_ES_PROT_UNSUPPORTED);
>  
>  	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
>  		return false;
> @@ -175,7 +175,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
>  	enum es_result result;
>  
>  	if (!boot_ghcb && !early_setup_sev_es())
> -		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
> +		sev_es_terminate(0, GHCB_SEV_ES_GEN_REQ);
>  
>  	vc_ghcb_invalidate(boot_ghcb);
>  	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
> @@ -202,5 +202,5 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
>  	if (result == ES_OK)
>  		vc_finish_insn(&ctxt);
>  	else if (result != ES_RETRY)
> -		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
> +		sev_es_terminate(0, GHCB_SEV_ES_GEN_REQ);
>  }
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index 11b7d9cea775..f1e2aacb0d61 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -59,4 +59,9 @@
>  
>  #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
>  
> +/* Linux specific reason codes (used with reason set 1) */
> +#define GHCB_TERM_REGISTER		0	/* GHCB GPA registration failure */
> +#define GHCB_TERM_PSC			1	/* Page State Change failure */
> +#define GHCB_TERM_PVALIDATE		2	/* Pvalidate failure */
> +
>  #endif
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 14198075ff8b..de0e7e6c52b8 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -24,7 +24,7 @@ static bool __init sev_es_check_cpu_features(void)
>  	return true;
>  }
>  
> -static void __noreturn sev_es_terminate(unsigned int reason)
> +static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
>  {
>  	u64 val = GHCB_MSR_TERM_REQ;
>  
> @@ -32,7 +32,7 @@ static void __noreturn sev_es_terminate(unsigned int reason)
>  	 * Tell the hypervisor what went wrong - only reason-set 0 is
>  	 * currently supported.
>  	 */

Since reason set 0 is not the only set supported anymore, maybe the part
about reason set 0 should be removed from the above comment?

Venu

> -	val |= GHCB_SEV_TERM_REASON(0, reason);
> +	val |= GHCB_SEV_TERM_REASON(set, reason);
>  
>  	/* Request Guest Termination from Hypvervisor */
>  	sev_es_wr_ghcb_msr(val);
> @@ -207,7 +207,7 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
>  
>  fail:
>  	/* Terminate the guest */
> -	sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
> +	sev_es_terminate(0, GHCB_SEV_ES_GEN_REQ);
>  }
>  
>  static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 460717e3f72d..77a754365ba9 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -1383,7 +1383,7 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
>  		show_regs(regs);
>  
>  		/* Ask hypervisor to sev_es_terminate */
> -		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
> +		sev_es_terminate(0, GHCB_SEV_ES_GEN_REQ);
>  
>  		/* If that fails and we get here - just panic */
>  		panic("Returned from Terminate-Request to Hypervisor\n");
> @@ -1416,7 +1416,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
>  
>  	/* Do initial setup or terminate the guest */
>  	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
> -		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
> +		sev_es_terminate(0, GHCB_SEV_ES_GEN_REQ);
>  
>  	vc_ghcb_invalidate(boot_ghcb);
>  
> -- 
> 2.17.1
> 
