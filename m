Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8493C708947
	for <lists+linux-efi@lfdr.de>; Thu, 18 May 2023 22:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjERUQ0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 May 2023 16:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjERUQZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 May 2023 16:16:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E3410CF;
        Thu, 18 May 2023 13:16:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCc6e8Jn8GQS64nfZf6SnUsnRwvQqjahKh9uYZlRmUEpBVha/HTvvKq78zzGB7YildGgnamv5rJtmRNKtskXqdA3FaFd6sexTxKNCS4seir+Lb785s6hZaZt/pHVxA9ULzVgYDSrzjvR/Bu2TK19/zRIS6myR7nCU4KMawFLCOv9sWz1aw6PxxqWvDwAznGN123d+N+yJF4XLtJ0fEVF+fXOlH6n/ROwaAtWpvWQPUgafYRkCSZhTFqIOGEL4ElDvF/XPqPmp8gVKzebOV2nyoY1dHsIlecBTEOMhQ46IifdkBSHOiHJdXSeAejPkmP2QsQRQxrWt6sj0ytFVg0Qpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VG99v+vQG1Td/e6xSPTsrGdle2ggqfc9wEqoB/nV6Y8=;
 b=Cy2S4aEM04yf7abmpmxSP4AdUaA5YBP+8czoDleZvmjy9lyJGJlAB+on1bJi3mjjrygOdUWobfBWPHb//vdOasiKtmjhEYlqh7G6C8IKQkmeCtsHkm5CYlQlO4Ae7vJQZEzWoE4cr4KZ0oLs/JjxoqYktkDGD92p5Z+4LS7UIPHSE1C91d7iG8dAGOSJ5q2Krb3gP3MYP3MQiVphdbScyt5dlgZcJjRnKMaONh5F2lRB7yQMkfdw2wnjD7FI9xwJwLE6Yhh22z+lzgkSA/awBnbDb6jHy6MqFnU3RAWvKGblboDqY2UDQPQZwY2ObVGZoD0E4+67F7Fa4utPn1qACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VG99v+vQG1Td/e6xSPTsrGdle2ggqfc9wEqoB/nV6Y8=;
 b=uFYHFOrHUYHHx6CTWtnaV7f31ynA6lg6yLSvZbf4jMCDGGIdnmMn3+atvIOzFTfjZdEKbLRDBc44WPSiphRbun1AMYbS2iFV33IRopq5n6Mi+BQ0LCxX0c+wpQG2NL+PAPzo52HUK0neGZgbdRQyQtopzLZjyUG3nZIOO5O5KCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by PH7PR12MB8054.namprd12.prod.outlook.com (2603:10b6:510:27f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 20:16:21 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 20:16:21 +0000
Message-ID: <ca76ed3b-5835-9f1b-7e10-dd417249b7bd@amd.com>
Date:   Thu, 18 May 2023 15:16:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 17/20] x86: efistub: Check SEV/SNP support while
 running in the firmware
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20230508070330.582131-1-ardb@kernel.org>
 <20230508070330.582131-18-ardb@kernel.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230508070330.582131-18-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0084.namprd04.prod.outlook.com
 (2603:10b6:805:f2::25) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|PH7PR12MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6a33a8-4ed3-4e61-a7cf-08db57dcbed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dr54JCC68yihWe3Ml11AGZVhGPuibsdceDJ2crfOhnHyjLfm/rMq3tfApGeyQVdKvJHqQpIgTVZuxLb6J39nPVI8KAunvnBtiRZ9jvyUSvN2GYn9Gte0rzpDagmOs/XCWvK7JKuA9w+DEj5Mgfbsw30lZHoAuLHxDXaGCx4ZBMmHvwq/HU/glbFX6v+GGYxFHmoZ3ACC9otDj9md6To30sWrSZ8K+BX9/JNrHslW4ELXH5lloR9oCWkLBz/Fq09p2p0o2iV5B4LhN+uGxTL540Cl+IvIieGCuZF9cOtkcWmzS67XT8QBh89g6H6Ak2cKFdg4w94b8Dkss0iHHZUpfh4gg+rOIQyf0ODkTK6spgCQ3irkBwdGHM0hFvhckRS1WwEkKIRQh/WJNd8J1FYjpuiGdsZCwb0zyRIKzpRE/lIyGU6SrMUIe8c3lpx76TF95zr+hqV615zMBUvFq7OwMlitcUdLCKHPRYat+DujznXWuqUf3EPQpoLalIA5w9V3ouxuBYlO1e3VJYsvzJQ7Lk77Dmxg9JSx51CaHz6lxOczQMqGYJcNxvdBztrpbOlxcewXP3RKieseOYkEcAq2CzElMfFPIfc+m7oyfL164rNFx9PA7KjRu4ptKlfe27N9qNZwv1KHnIDQYC10sOMjuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(8676002)(5660300002)(8936002)(4326008)(7416002)(6512007)(6506007)(83380400001)(26005)(31696002)(86362001)(186003)(53546011)(38100700002)(2616005)(41300700001)(66476007)(6666004)(478600001)(66556008)(66946007)(6486002)(54906003)(36756003)(316002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SitxcXRSeTJLSTZGV1ZTMGtKUEJHa1FnUDFFbDBWNFh0YUdKVzljaGpGMitJ?=
 =?utf-8?B?U0pPYnhtemNmWmNwVXVvYVhKTm1Vd3gxTmFSOFRuamlNZi91TUlGOUs3dm5P?=
 =?utf-8?B?aVB1ZUxaMHJvTEY5aEl4UjRNNUZHZFdGc01SaWtuejA2RXMvRmZPMFpnSDho?=
 =?utf-8?B?eHp3TG1Qdkw0cVVMS0haMmRjMG5LOUpVRzU4MjlHR01VRk8wb3F2bjF0NERy?=
 =?utf-8?B?dG0zVEZ5ZThJdHBBbE1mUG9SZU9Dd0dsZ2IwejdFR1JsNThscURsNmlRMEh2?=
 =?utf-8?B?eU1ZazdOK3l5NTRxTmk2am9NQWZEYWxiR1NHcFVxTFZhb0FIcDlLVkRvck5Q?=
 =?utf-8?B?aXF5enhkaTVzeXh6QkQrZmpFM0RXaStDR0VOb1F1cllmV3NHRmF3eUE3bjRD?=
 =?utf-8?B?dlBZK3I3MUc3NVd4TytBVlR5S2t4VG5rVTU4MFV1R3o3T3I3M010MGlxdTFS?=
 =?utf-8?B?akpQSS9iMWxudjJvYzN3a1NiSndab3NGZnNTcGpXRHBCV2pnc29aRWhxOVhq?=
 =?utf-8?B?d0dTOWFldEdrM1dTYW5VUVdjL2dZaXJXMzZhRkpKZ0UyeFV4VXdUYUE2eHBE?=
 =?utf-8?B?Z3owQ1oxYzIxYTZlczBqUEVwMHJFQWhkbDZldG1FcDdndWRJT3l3Q0RlQ0NR?=
 =?utf-8?B?Q3RKVDdCTTFTOXlhcVZQdDAwT0x6dU9hdXhCZVVmTWpSRXVJY0RQY2Uza3lo?=
 =?utf-8?B?TjU3NXFvOWxNeWhEVUIwcW42SmRrQnRrZGpGR3lJblVkcjY4MDVQakNHd3Ar?=
 =?utf-8?B?KzJ4WUZzRUZyOXduMEpoQ1lBVjVaOFVCcUpoR2ZYRjJibkVjRDIva1VyVXpa?=
 =?utf-8?B?RWprRnZhUHhsLzhGWFFYVHByTWJ0U1NPcW1OOUFaaFA0L3RLaUliQWxmMjQ4?=
 =?utf-8?B?ckVpZzBBaG9QeEw1MUFGeTlFZStCeXMwd002dUVoRnVsaXo4UmVMbEVSRzhp?=
 =?utf-8?B?ZkhwUEtNRU5lZGZNWDN2cFZvMGVQUEw3MFUzMHZHS3puQ1IxS0pRSGpDcjZI?=
 =?utf-8?B?MVRBemJvS3kyRG5jMlFpQ0Z1aGF4M0tVeXF3ZGtrTzYxVjkxVWNXbW9JYXkv?=
 =?utf-8?B?WUNpLzdYL3ZncUlIQ3lOUnBZemRNV2hpbUVFZG1mekhrUW00dVgvMHhEYW9r?=
 =?utf-8?B?ZXg3OFVOZ0JQWCsxUFBGeGp3eHRnQ2dCR0ErWXhzTVdHL2ptSUtsbXBlWnE3?=
 =?utf-8?B?MjRlcWYxMVpqRGxkS0ZBUU45S3RhYnQ4bjY0bXM3ZDZKNW5KWm11UkI1UHps?=
 =?utf-8?B?bHErOUNFK1lWVmxqOWRXNjBMQ2RaWGNaYnlUd2dsdXJYTExRUEl2aFdHVTIy?=
 =?utf-8?B?cHNzWjJoMEpnd0ZSVFZJemgreDF1aEcwVzc4UWdJRjQxSXFnMnZNM1Y1bWhx?=
 =?utf-8?B?K1pHejQ5YktTYVhCUlA5dTE2LzZFcDJhekZkeVlOdHBXbmVudHhHK2g0NHVT?=
 =?utf-8?B?Qm90SjVWVWtwS2kwUFAvYjhTQmR4Z0lYQUk5YWF1bHhaZUx0TEJ4WEZnTlMy?=
 =?utf-8?B?WUFaeHo2VnMrNlljL0QyQXpneE9hUmZLYWZ6SUxqUEZLcmJHdWhoUnNIaXpi?=
 =?utf-8?B?NkxEZmVhQ1lwc3JqRGZQNWR1NUtuN0swcHZJcmJGbWF4bDZ5dS9qUW0rdytR?=
 =?utf-8?B?WXc2UXp4bzlsakhscWRzbnRXYldzRG5HQ0RDT0crVDdkZWxEYXNoVXJleW5S?=
 =?utf-8?B?Z0hXakJHdUZJWWkwRVk0L0hISXd6ZmJVcnRxWHlkRDY3VmMxbENncUh3bVNz?=
 =?utf-8?B?c1hIcDFkZllFSVdrRUlHUytnNXp1MlNHY0cvdEViK0dRbE42SjRYMFJhNTVn?=
 =?utf-8?B?cXRlTW15ZkFNUDRWa0VtS3Zva3ZGMERmdHE4aVlVWlZxMHRXUG1RMy8wbEpw?=
 =?utf-8?B?bm5FLzd6dmM1MVFzN2RqSmF3eDFnQm9PcTFJUzdhcDMxU1dkOFdNdmRSb3dl?=
 =?utf-8?B?d0NRUlVJRzJVVVBmOVNDMVJ2Q3R6YnpHNXlhUnp4dlJmMWIxM1JMUVhRNkxB?=
 =?utf-8?B?NFJkTjIrZUUwT3FjV0Zra3pxOVNQZndDTlB4SmVKTE04WFh1WHJWQUExOUsz?=
 =?utf-8?B?TnUyN0lQOG9KaTZGYW5VTlpKb0IxRy94b3dXakpTRm50ZVFMNXE4aDBqU25s?=
 =?utf-8?Q?jcIepMY3hfizWOpqa6oiHBMgc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6a33a8-4ed3-4e61-a7cf-08db57dcbed5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 20:16:21.1317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wfdi341qjsYGclYPyZLtGdnzRtZleQKuh9B2ZRXx9UQVvl670vQACbjK0En9r5rZK+4F3IEnQ2J4O7KKKaZaGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8054
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/8/23 02:03, Ard Biesheuvel wrote:
> The decompressor executes in an environment with little or no access to
> a console, and without any ability to return an error back to the caller
> (the bootloader). So the only recourse we have when the SEV/SNP context
> is not quite what the kernel expects is to terminate the guest entirely.
> 
> This is a bit harsh, and also unnecessary when booting via the EFI stub,
> given that it provides all the support that SEV guests need to probe the
> underlying platform.
> 
> So let's do the SEV initialization and SNP feature check before calling
> ExitBootServices(), and simply return with an error if the SNP feature
> mask is not as expected.

My SEV-ES / SEV-SNP guests started crashing when I applied this patch.
Turns out that sev_es_negotiate_protocol() used to be called when no #VC
exceptions were being generated before a valid GHCB was setup. Because
of that the current GHCB MSR value was not saved/restored. But now,
sev_es_negotiate_protocol() is called earlier in the boot process and
there are still messages being issued by UEFI, e.g.:

SetUefiImageMemoryAttributes - 0x000000007F6D7000 - 0x0000000000006000 (0x0000000000000008)

Similarly, get_hv_features() didn't worry about saving the GHCB MSR value
and an SNP guest crashed after fixing sev_es_negotiate_protocol().

The following changes got me past everything:

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 3a5b0c9c4fcc..23450628d41c 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -106,15 +106,19 @@ static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
   */
  static u64 get_hv_features(void)
  {
-	u64 val;
+	u64 val, save;
  
  	if (ghcb_version < 2)
  		return 0;
  
+	save = sev_es_rd_ghcb_msr();
+
  	sev_es_wr_ghcb_msr(GHCB_MSR_HV_FT_REQ);
  	VMGEXIT();
-
  	val = sev_es_rd_ghcb_msr();
+
+	sev_es_wr_ghcb_msr(save);
+
  	if (GHCB_RESP_CODE(val) != GHCB_MSR_HV_FT_RESP)
  		return 0;
  
@@ -139,13 +143,17 @@ static void snp_register_ghcb_early(unsigned long paddr)
  
  static bool sev_es_negotiate_protocol(void)
  {
-	u64 val;
+	u64 val, save;
+
+	save = sev_es_rd_ghcb_msr();
  
  	/* Do the GHCB protocol version negotiation */
  	sev_es_wr_ghcb_msr(GHCB_MSR_SEV_INFO_REQ);
  	VMGEXIT();
  	val = sev_es_rd_ghcb_msr();
  
+	sev_es_wr_ghcb_msr(save);
+
  	if (GHCB_MSR_INFO(val) != GHCB_MSR_SEV_INFO_RESP)
  		return false;
  

Thanks,
Tom

> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>   arch/x86/boot/compressed/sev.c          | 12 ++++++++----
>   arch/x86/include/asm/sev.h              |  4 ++++
>   drivers/firmware/efi/libstub/x86-stub.c | 17 +++++++++++++++++
>   3 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 014b89c890887b9a..19c40873fdd209b5 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -315,20 +315,24 @@ static void enforce_vmpl0(void)
>    */
>   #define SNP_FEATURES_PRESENT (0)
>   
> +u64 snp_get_unsupported_features(void)
> +{
> +	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
> +		return 0;
> +	return sev_status & SNP_FEATURES_IMPL_REQ & ~SNP_FEATURES_PRESENT;
> +}
> +
>   void snp_check_features(void)
>   {
>   	u64 unsupported;
>   
> -	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
> -		return;
> -
>   	/*
>   	 * Terminate the boot if hypervisor has enabled any feature lacking
>   	 * guest side implementation. Pass on the unsupported features mask through
>   	 * EXIT_INFO_2 of the GHCB protocol so that those features can be reported
>   	 * as part of the guest boot failure.
>   	 */
> -	unsupported = sev_status & SNP_FEATURES_IMPL_REQ & ~SNP_FEATURES_PRESENT;
> +	unsupported = snp_get_unsupported_features();
>   	if (unsupported) {
>   		if (ghcb_version < 2 || (!boot_ghcb && !early_setup_ghcb()))
>   			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 13dc2a9d23c1eb25..bf27b91644d0da5a 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -157,6 +157,7 @@ static __always_inline void sev_es_nmi_complete(void)
>   		__sev_es_nmi_complete();
>   }
>   extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
> +extern void sev_enable(struct boot_params *bp);
>   
>   static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs)
>   {
> @@ -202,12 +203,14 @@ void snp_set_wakeup_secondary_cpu(void);
>   bool snp_init(struct boot_params *bp);
>   void __init __noreturn snp_abort(void);
>   int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
> +u64 snp_get_unsupported_features(void);
>   #else
>   static inline void sev_es_ist_enter(struct pt_regs *regs) { }
>   static inline void sev_es_ist_exit(void) { }
>   static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
>   static inline void sev_es_nmi_complete(void) { }
>   static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
> +static inline void sev_enable(struct boot_params *bp) { }
>   static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
>   static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
>   static inline void setup_ghcb(void) { }
> @@ -225,6 +228,7 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
>   {
>   	return -ENOTTY;
>   }
> +static inline u64 snp_get_unsupported_features(void) { return 0; }
>   #endif
>   
>   #endif
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index ce8434fce0c37982..33d11ba78f1d8c4f 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -15,6 +15,7 @@
>   #include <asm/setup.h>
>   #include <asm/desc.h>
>   #include <asm/boot.h>
> +#include <asm/sev.h>
>   
>   #include "efistub.h"
>   
> @@ -714,6 +715,22 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
>   			  &p->efi->efi_memmap, &p->efi->efi_memmap_hi);
>   	p->efi->efi_memmap_size		= map->map_size;
>   
> +	/*
> +	 * Call the SEV init code while still running with the firmware's
> +	 * GDT/IDT, so #VC exceptions will be handled by EFI.
> +	 */
> +	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
> +		u64 unsupported;
> +
> +		sev_enable(p->boot_params);
> +		unsupported = snp_get_unsupported_features();
> +		if (unsupported) {
> +			efi_err("Unsupported SEV-SNP features detected: 0x%llx\n",
> +				unsupported);
> +			return EFI_UNSUPPORTED;
> +		}
> +	}
> +
>   	return EFI_SUCCESS;
>   }
>   
