Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F907237DC
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jun 2023 08:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjFFGj0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Jun 2023 02:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjFFGjZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Jun 2023 02:39:25 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7065EC7;
        Mon,  5 Jun 2023 23:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIWt2wcVq7IGt/fLZdFFPYebTnS2KcgaONgDN6axdiZKy2nRqVGx/CfhVIQYTpzSdKeFFP8MBqLIvDYWrByAK+pOSSahp6/i7qeoZfMsTWAzaggm+hKexpgNBcMIOJ7jJw0BjzPQdsPPXcCzJnRVMih9eDGSC51efA3qu3jepELKYjzPcfxsxESlk69vHssThbRREJu8jHYhX++vuV8KVMJv1Vr/5ESbQOZHWjlD8qxHxefI9LpQITqa4ltCnevvQNFAE4Vfs4r/45eJ+OAHC9hgU7IH/4OulsY21tPOcL+fx0oBM2cg+FOIgWst/CjtOkZjfSPbxQo0BXPAy5fiJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWmMvWLkNvAmigtgWqy94MfUnAA8dtQFZUx2yly0Ud0=;
 b=EcjmFgSgOF+HQp3cx4O6fjLwP6wzLB886fCIMPZ8oSQAuE512praGWKHE2Vd1R3VTPbIosbXmyUx69hzFZxPM0hy5abvZUI4G78Emc9IOaG9rmEHgLZuC18gvBMozSpEG+3tfdut0M4nbdhemZUS4u2FF+1fzPY9GzmaLyFakp+p2T3H862BV1+lgXgHjxvVshGLtydJzofcgqfvJvdpLQHgMUtDhQx6keyg6y9RSEyb+3qedhpckyL3+xUlsDDjf0A9Ik3zxB9yiNeesdmQjuslre/lERswSVlClaKLZjaNUEGhXdMseLil1cphvojDPC5BKZjiOvF3OtwXAkenyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWmMvWLkNvAmigtgWqy94MfUnAA8dtQFZUx2yly0Ud0=;
 b=SDaTaylexZywNJYfIbILnk0tlz4Cu+Vy4K+tqBm+Y9wvtMdlT9kwnXF9/g6AAKYqLeFwx0IvflzXvtdEXG8ajX74gHEuZSovGzFAaWaKJwtuQaaoFkPR6I5BzFhllEQ4yKQece5+epAZZXTHI8T5QE9V8u72h4sLef3XMSuPhWlaSz/BZMdNbGX6eit7dbqJtnaMXz2v2109R3+dOsJZfjiBrv2RshBKaV2MBM1AZMWWBxxewl0WXkyHY9wiFGcHFJULXcV4fYCbwKYj/bUR5Am2KIt6JD6aaUou0abbaXHsCU9GpzoDAjdkltmFYoqYegVX+hUruaTbxEWLAHXwEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:39:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:39:16 +0000
Message-ID: <0d3e0370-eb76-010f-3d30-9acc9b59645c@siemens.com>
Date:   Tue, 6 Jun 2023 08:39:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
Content-Language: en-US
To:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
References: <20230526010748.1222-1-masahisa.kojima@linaro.org>
 <20230526010748.1222-4-masahisa.kojima@linaro.org>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230526010748.1222-4-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:610:e6::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3167:EE_
X-MS-Office365-Filtering-Correlation-Id: c819d897-8e3b-4b21-d040-08db6658bfb9
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I2A2+OhqNKP/0HSeDGNDr1evZVSGAKvxh4RPgbZjgJZaMvd97sI79FFMR6VaZpn2HlsG1+v1iVbRIbIQPy7aoymWYF6CwzJJgilRpuQH2CXr01yanrHgBgzwBxJ3koCAl1hQGFBv4+8BfzSXOHQQHdfTKYXUWOK7UcqO4T4So6picRlvfeBn0QKI1rJQ7PNb/3N7fcqtJJ03nKVld87BXtIbCejJ0pxKWTcNt0eJGYfC8PYUjxu336qJtXrvcFz1SnuX/pfoSQalntADERYE2sM149zcNqd3unwSXFDr+R/ELSRKw9ubPC8z4qk/ur/+NruPJGYtEhb1k7cNs11HzkGo68Jw4qGg+UjEdwnmJeSaPjconoUW7u1YAZHZwI3W+9BZW5EIOdqejW1Uv77xxtSXetEPCQsQBvW9yykP/vNGuR57v0IUWRBOK7T31kQpuOtbPEQ3WD4dXhHYA6YerWDultIi7gPnSdSS1eKCzmYp2rV5EARTyyybxu/ThwWiV/DoFaycXJKJgNPD9THacE+vtspMAOlusAAQGqCgInMYPzelsRtLYw6qBYtADSlnmircS6N83sBXhedu2JvAYAKh/M5pjt7gjR6c15OMu6OClwhxvVek/1HENsVzu8nxYwpM9ynM3FkygAjfFJnDAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199021)(110136005)(54906003)(478600001)(82960400001)(8936002)(5660300002)(8676002)(44832011)(30864003)(7416002)(36756003)(86362001)(31696002)(2906002)(66946007)(66556008)(66476007)(316002)(4326008)(38100700002)(41300700001)(2616005)(107886003)(53546011)(6512007)(6506007)(186003)(26005)(83380400001)(6486002)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnlrTDNWN25DZkxqUmZRTk8zTm9jS3VnNFQ0VEllVnVSUFQxWXcyZWUwMFFL?=
 =?utf-8?B?WlJBSjVxVzlqdGhqdnhZbnhiTGRqaGFub0d3YlUwa2RmVTFleVZkM3FaTzF1?=
 =?utf-8?B?R3VKYlFDVU5vSlE3bnIrOW55N00zYjd4NitZUEtyUHZWRzJobTNyQVZWNWhj?=
 =?utf-8?B?VVlOMHhvRFdnNWZWeUsvbitva3c4T3VCbllCRlNUaG9SVWxscU1BNjFFUDhk?=
 =?utf-8?B?dElFMU50YmxhK0xEeUZJWU1FS2xHcmZtakE1eTE5aTlZcXZlYVFaNXR3SXFQ?=
 =?utf-8?B?L08vM29BS2ZIR2QvSlhiNVJsSmszNjRxQmJWZmpBSDIvUjJDUjBObW9kK2hN?=
 =?utf-8?B?bmFWcTdDQU5xaXVzbk9DVER2NnpDL0Fzb3BrdU8yb2tEVjl3ZzZRVUFRU2VV?=
 =?utf-8?B?ekhra3RuZzQwc3d3c2x1UGs4eS9BRENQQk1YWnRBNGM4RGxNTVdieUU4OHpL?=
 =?utf-8?B?aVhoQ08rTHNPWERzRU9mNWwrOWFUOWNpMVBZZlphYUlwcUpvcWtNSHhIUlMw?=
 =?utf-8?B?cU1UNk5jSXZjSjFaK09iUytZL0xGYm92ckVlY1dEUkdyZWsyN3JER1NVelV5?=
 =?utf-8?B?cUtHOUE0WUc3dE1NQUM5bG9HV3RWQ1BmL1pnNGlXYUZsamtvQjl2dm4wZGxM?=
 =?utf-8?B?RzRtWkVVZFJod2ZpU05MTkF2V2NEcEN5Q3lURmhiZyt1TVEzT2hlUm1veHk3?=
 =?utf-8?B?WEZxKzh0Z24xM0owL2pvMmI0L2FPc1R1T1JVbmN1Vms0RExMbDk4WmJGSmx3?=
 =?utf-8?B?ZVlsT0V3eG1CbERzWHY3YmxJNXFyRmN4UmZ1UmZpRVBwSjZsazl2RDJURzlO?=
 =?utf-8?B?elovejlMWHVVM2JwNFhWVTE0cWFXeHMzd3dpWXg0dWhMZW9oWG9tWFoxdXpm?=
 =?utf-8?B?YnA0Vms3ZFF0MnlEWnZHTFQ2c3BVZVNIZ2dNc0x0c3FXRXNKTzJZVVAwSlVG?=
 =?utf-8?B?bU1ZMnpUZk9qMnhHd25YdXFQNGFxVmFoSmxjQ1NNYkJyL0JrenBrdnVyWis1?=
 =?utf-8?B?NjVIQWhIRnhxb3VKZFdLWjE1WFhac0lka29GdjFNL0dQN202QjExQnBmZ0FR?=
 =?utf-8?B?QTNGQWFsZXhDdHE4VlJmT2w0SldxZC9hN2RNZWJIejFQdXYrNDZMbHJqOFlx?=
 =?utf-8?B?MmxjTlIra2hMSmsxOUV3S0xqbUFHRUZOb2syc0Vna0tNdDBPSVFhU2xNUGVO?=
 =?utf-8?B?Z3M4U3JwRVJQMmYybDkwK3dkSlBUU2FEVGJSM2lTNFdZSmVRMjVDVUF1cHhQ?=
 =?utf-8?B?Q0FFeStFOHIwUFdJbHlSeDJyOEdqS0lsSmZVSTVUYzVkTlZZaHJyKzVrQnMz?=
 =?utf-8?B?eFJ1Z0VOcWgrbEZLalJrZTZ5Z3BJYldNQXphUjV5YXBMdUV6dXoyQlJ3bGJI?=
 =?utf-8?B?VjNmS25vOXRTNFVtbDF0ckxxb3ovdFFnb1FZYkNRWlFyZGlrcmhOcllhS0Rx?=
 =?utf-8?B?UjlKd1gvYWtKS0thamxkU2FzVUo3ZU95OUU2bVdtbklUZFJnN2N3TUQwMERh?=
 =?utf-8?B?WlIxQTNzMUFWNWpFeitwb0RydDBya1VleGRINjdlT1cwYURqQ1NnVXdNUlhq?=
 =?utf-8?B?VlJqMmxaYThzY0VRV0RHR0x1azZPbFFNd2FWSTE1NlFxb2xMVTlNandvbXl5?=
 =?utf-8?B?QnllcmgwZDRUVnR5blFiZnIvajRVYVErRW4veW5Sc3NuZG9aMFpXUWxRcGZq?=
 =?utf-8?B?TTN6TVRtUlRiZFJEY2t5dXZ6ZjRONDFsNktWUTFNQWNSU0ZDTnI2YkFtaXA5?=
 =?utf-8?B?REJQT2ZpK1g4a0svTHdKQWNZemhSV3dZTklYTzRQL2RRNmhqaCs2TkJWTHZR?=
 =?utf-8?B?cmNVazByZFJLaFRaSFAyMk5xcDk2K3V0ZDBtZnY0UzBNWkJObjJkNURsREVw?=
 =?utf-8?B?bUd5ZHVPSkdyU296WG52bFY1U2sxcFpjdWhER1hXZFkrWmx0UUVyQ2RPdEtj?=
 =?utf-8?B?a2wwRjhUeVQ4aFYrM1FINENBN3cxS1I5SjJ4NnIrNHZtL09tWXdiRForY01s?=
 =?utf-8?B?WHhVUmpldDhPRFFMdXBKMEFDQ2JGOVdxUWNGMC8ycnh6V1Jpb2prWmhYQWd0?=
 =?utf-8?B?cjB5djluZmQwYURUcGJqbHhHMFlNMVYweFVXMkhzbUxsa0NjVmc4VGYwSTFY?=
 =?utf-8?B?UHJ6enJEY1UwNE9EN0hkdXRrT29ZTDJpTE1LUWdMOFh1YVI0N0svZU55M1ZW?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c819d897-8e3b-4b21-d040-08db6658bfb9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:39:16.7206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9o14XnZyQ0ZViCbIgac45of5+csHlQlx5rH9D/U+PGr5ha2dLeeCtKq3Rm/4tpNXwVBtzZk8KlXFZv3jbhy+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3167
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 26.05.23 03:07, Masahisa Kojima wrote:
> When the flash is not owned by the non-secure world, accessing the EFI
> variables is straightforward and done via EFI Runtime Variable Services.
> In this case, critical variables for system integrity and security
> are normally stored in the dedicated secure storage and only accessible
> from the secure world.
> 
> On the other hand, the small embedded devices don't have the special
> dedicated secure storage. The eMMC device with an RPMB partition is
> becoming more common, we can use an RPMB partition to store the
> EFI Variables.
> 
> The eMMC device is typically owned by the non-secure world(linux in
> this case). There is an existing solution utilizing eMMC RPMB partition
> for EFI Variables, it is implemented by interacting with
> TEE(OP-TEE in this case), StandaloneMM(as EFI Variable Service Pseudo TA),
> eMMC driver and tee-supplicant. The last piece is the tee-based
> variable access driver to interact with TEE and StandaloneMM.
> 
> So let's add the kernel functions needed.
> 
> This feature is implemented as a kernel module.
> StMM PTA has TA_FLAG_DEVICE_ENUM_SUPP flag when registered to OP-TEE
> so that this tee_stmm_efi module is probed after tee-supplicant starts,
> since "SetVariable" EFI Runtime Variable Service requires to
> interact with tee-supplicant.
> 
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
> Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  drivers/firmware/efi/Kconfig                 |  15 +
>  drivers/firmware/efi/Makefile                |   1 +
>  drivers/firmware/efi/stmm/mm_communication.h | 236 +++++++
>  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 638 +++++++++++++++++++
>  4 files changed, 890 insertions(+)
>  create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
>  create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c
> 
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 043ca31c114e..aa38089d1e4a 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -287,3 +287,18 @@ config UEFI_CPER_X86
>  	bool
>  	depends on UEFI_CPER && X86
>  	default y
> +
> +config TEE_STMM_EFI
> +	tristate "TEE based EFI runtime variable service driver"
> +	depends on EFI && OPTEE && !EFI_VARS_PSTORE
> +	help
> +	  Select this config option if TEE is compiled to include StandAloneMM
> +	  as a separate secure partition it has the ability to check and store
> +	  EFI variables on an RPMB or any other non-volatile medium used by
> +	  StandAloneMM.
> +
> +	  Enabling this will change the EFI runtime services from the firmware
> +	  provided functions to TEE calls.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called tee_stmm_efi.
> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> index b51f2a4c821e..2ca8ee6ab490 100644
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -41,3 +41,4 @@ obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
>  obj-$(CONFIG_EFI_EARLYCON)		+= earlycon.o
>  obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
>  obj-$(CONFIG_UEFI_CPER_X86)		+= cper-x86.o
> +obj-$(CONFIG_TEE_STMM_EFI)		+= stmm/tee_stmm_efi.o
> diff --git a/drivers/firmware/efi/stmm/mm_communication.h b/drivers/firmware/efi/stmm/mm_communication.h
> new file mode 100644
> index 000000000000..52a1f32cd1eb
> --- /dev/null
> +++ b/drivers/firmware/efi/stmm/mm_communication.h
> @@ -0,0 +1,236 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + *  Headers for EFI variable service via StandAloneMM, EDK2 application running
> + *  in OP-TEE. Most of the structs and defines resemble the EDK2 naming.
> + *
> + *  Copyright (c) 2017, Intel Corporation. All rights reserved.
> + *  Copyright (C) 2020 Linaro Ltd.
> + */
> +
> +#ifndef _MM_COMMUNICATION_H_
> +#define _MM_COMMUNICATION_H_
> +
> +/*
> + * Interface to the pseudo Trusted Application (TA), which provides a
> + * communication channel with the Standalone MM (Management Mode)
> + * Secure Partition running at Secure-EL0
> + */
> +
> +#define PTA_STMM_CMD_COMMUNICATE 0
> +
> +/*
> + * Defined in OP-TEE, this UUID is used to identify the pseudo-TA.
> + * OP-TEE is using big endian GUIDs while UEFI uses little endian ones
> + */
> +#define PTA_STMM_UUID \
> +	UUID_INIT(0xed32d533, 0x99e6, 0x4209, \
> +		  0x9c, 0xc0, 0x2d, 0x72, 0xcd, 0xd9, 0x98, 0xa7)
> +
> +#define EFI_MM_VARIABLE_GUID \
> +	EFI_GUID(0xed32d533, 0x99e6, 0x4209, \
> +		 0x9c, 0xc0, 0x2d, 0x72, 0xcd, 0xd9, 0x98, 0xa7)
> +
> +/**
> + * struct efi_mm_communicate_header - Header used for SMM variable communication
> +
> + * @header_guid:  header use for disambiguation of content
> + * @message_len:  length of the message. Does not include the size of the
> + *                header
> + * @data:         payload of the message
> + *
> + * Defined in the PI spec as EFI_MM_COMMUNICATE_HEADER.
> + * To avoid confusion in interpreting frames, the communication buffer should
> + * always begin with efi_mm_communicate_header.
> + */
> +struct efi_mm_communicate_header {
> +	efi_guid_t header_guid;
> +	size_t     message_len;
> +	u8         data[];
> +} __packed;
> +
> +#define MM_COMMUNICATE_HEADER_SIZE \
> +	(sizeof(struct efi_mm_communicate_header))
> +
> +/* SPM return error codes */
> +#define ARM_SVC_SPM_RET_SUCCESS               0
> +#define ARM_SVC_SPM_RET_NOT_SUPPORTED        -1
> +#define ARM_SVC_SPM_RET_INVALID_PARAMS       -2
> +#define ARM_SVC_SPM_RET_DENIED               -3
> +#define ARM_SVC_SPM_RET_NO_MEMORY            -5
> +
> +#define SMM_VARIABLE_FUNCTION_GET_VARIABLE  1
> +/*
> + * The payload for this function is
> + * SMM_VARIABLE_COMMUNICATE_GET_NEXT_VARIABLE_NAME.
> + */
> +#define SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME  2
> +/*
> + * The payload for this function is SMM_VARIABLE_COMMUNICATE_ACCESS_VARIABLE.
> + */
> +#define SMM_VARIABLE_FUNCTION_SET_VARIABLE  3
> +/*
> + * The payload for this function is
> + * SMM_VARIABLE_COMMUNICATE_QUERY_VARIABLE_INFO.
> + */
> +#define SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO  4
> +/*
> + * It is a notify event, no extra payload for this function.
> + */
> +#define SMM_VARIABLE_FUNCTION_READY_TO_BOOT  5
> +/*
> + * It is a notify event, no extra payload for this function.
> + */
> +#define SMM_VARIABLE_FUNCTION_EXIT_BOOT_SERVICE  6
> +/*
> + * The payload for this function is VARIABLE_INFO_ENTRY.
> + * The GUID in EFI_SMM_COMMUNICATE_HEADER is gEfiSmmVariableProtocolGuid.
> + */
> +#define SMM_VARIABLE_FUNCTION_GET_STATISTICS  7
> +/*
> + * The payload for this function is SMM_VARIABLE_COMMUNICATE_LOCK_VARIABLE
> + */
> +#define SMM_VARIABLE_FUNCTION_LOCK_VARIABLE   8
> +
> +#define SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_SET  9
> +
> +#define SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET  10
> +
> +#define SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE  11
> +/*
> + * The payload for this function is
> + * SMM_VARIABLE_COMMUNICATE_RUNTIME_VARIABLE_CACHE_CONTEXT
> + */
> +#define SMM_VARIABLE_FUNCTION_INIT_RUNTIME_VARIABLE_CACHE_CONTEXT 12
> +
> +#define SMM_VARIABLE_FUNCTION_SYNC_RUNTIME_CACHE  13
> +/*
> + * The payload for this function is
> + * SMM_VARIABLE_COMMUNICATE_GET_RUNTIME_CACHE_INFO
> + */
> +#define SMM_VARIABLE_FUNCTION_GET_RUNTIME_CACHE_INFO  14
> +
> +/**
> + * struct smm_variable_communicate_header - Used for SMM variable communication
> +
> + * @function:     function to call in Smm.
> + * @ret_status:   return status
> + * @data:         payload
> + */
> +struct smm_variable_communicate_header {
> +	size_t  function;
> +	efi_status_t ret_status;
> +	u8 data[];
> +};
> +
> +#define MM_VARIABLE_COMMUNICATE_SIZE \
> +	(sizeof(struct smm_variable_communicate_header))
> +
> +/**
> + * struct smm_variable_access - Used to communicate with StMM by
> + *                              SetVariable and GetVariable.
> +
> + * @guid:         vendor GUID
> + * @data_size:    size of EFI variable data
> + * @name_size:    size of EFI name
> + * @attr:         attributes
> + * @name:         variable name
> + *
> + */
> +struct smm_variable_access {
> +	efi_guid_t  guid;
> +	size_t data_size;
> +	size_t name_size;
> +	u32 attr;
> +	u16 name[];
> +};
> +
> +#define MM_VARIABLE_ACCESS_HEADER_SIZE \
> +	(sizeof(struct smm_variable_access))
> +/**
> + * struct smm_variable_payload_size - Used to get the max allowed
> + *                                    payload used in StMM.
> + *
> + * @size:  size to fill in
> + *
> + */
> +struct smm_variable_payload_size {
> +	size_t size;
> +};
> +
> +/**
> + * struct smm_variable_getnext - Used to communicate with StMM for
> + *                               GetNextVariableName.
> + *
> + * @guid:       vendor GUID
> + * @name_size:  size of the name of the variable
> + * @name:       variable name
> + *
> + */
> +struct smm_variable_getnext {
> +	efi_guid_t  guid;
> +	size_t name_size;
> +	u16         name[];
> +};
> +
> +#define MM_VARIABLE_GET_NEXT_HEADER_SIZE \
> +	(sizeof(struct smm_variable_getnext))
> +
> +/**
> + * struct smm_variable_query_info - Used to communicate with StMM for
> + *                                  QueryVariableInfo.
> + *
> + * @max_variable_storage:        max available storage
> + * @remaining_variable_storage:  remaining available storage
> + * @max_variable_size:           max variable supported size
> + * @attr:                        attributes to query storage for
> + *
> + */
> +struct smm_variable_query_info {
> +	u64 max_variable_storage;
> +	u64 remaining_variable_storage;
> +	u64 max_variable_size;
> +	u32 attr;
> +};
> +
> +#define VAR_CHECK_VARIABLE_PROPERTY_REVISION 0x0001
> +#define VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY BIT(0)
> +/**
> + * struct var_check_property - Used to store variable properties in StMM
> + *
> + * @revision:   magic revision number for variable property checking
> + * @property:   properties mask for the variable used in StMM.
> + *              Currently RO flag is supported
> + * @attributes: variable attributes used in StMM checking when properties
> + *              for a variable are enabled
> + * @minsize:    minimum allowed size for variable payload checked against
> + *              smm_variable_access->datasize in StMM
> + * @maxsize:    maximum allowed size for variable payload checked against
> + *              smm_variable_access->datasize in StMM
> + *
> + */
> +struct var_check_property {
> +	u16 revision;
> +	u16 property;
> +	u32 attributes;
> +	size_t minsize;
> +	size_t maxsize;
> +};
> +
> +/**
> + * struct smm_variable_var_check_property - Used to communicate variable
> + *                                          properties with StMM
> + *
> + * @guid:       vendor GUID
> + * @name_size:  size of EFI name
> + * @property:   variable properties struct
> + * @name:       variable name
> + *
> + */
> +struct smm_variable_var_check_property {
> +	efi_guid_t guid;
> +	size_t name_size;
> +	struct var_check_property property;
> +	u16 name[];
> +};
> +
> +#endif /* _MM_COMMUNICATION_H_ */
> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> new file mode 100644
> index 000000000000..f6623171ae04
> --- /dev/null
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> @@ -0,0 +1,638 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  EFI variable service via TEE
> + *
> + *  Copyright (C) 2022 Linaro
> + */
> +
> +#include <linux/efi.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/tee.h>
> +#include <linux/tee_drv.h>
> +#include <linux/ucs2_string.h>
> +#include "mm_communication.h"
> +
> +static struct efivars tee_efivars;
> +static struct efivar_operations tee_efivar_ops;
> +
> +static size_t max_buffer_size; /* comm + var + func + data */
> +static size_t max_payload_size; /* func + data */
> +
> +struct tee_stmm_efi_private {
> +	struct tee_context *ctx;
> +	u32 session;
> +	struct device *dev;
> +};
> +
> +static struct tee_stmm_efi_private pvt_data;
> +
> +/* UUID of the stmm PTA */
> +static const struct tee_client_device_id tee_stmm_efi_id_table[] = {
> +	{PTA_STMM_UUID},
> +	{}
> +};
> +
> +static int tee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
> +{
> +	/* currently only OP-TEE is supported as a communication path */
> +	if (ver->impl_id == TEE_IMPL_ID_OPTEE)
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +/**
> + * tee_mm_communicate() - Pass a buffer to StandaloneMM running in TEE
> + *
> + * @comm_buf:		locally allocated communication buffer
> + * @dsize:		buffer size
> + * Return:		status code
> + */
> +static efi_status_t tee_mm_communicate(void *comm_buf, size_t dsize)
> +{
> +	size_t buf_size;
> +	efi_status_t ret;
> +	struct efi_mm_communicate_header *mm_hdr;
> +	struct tee_ioctl_invoke_arg arg;
> +	struct tee_param param[4];
> +	struct tee_shm *shm = NULL;
> +	int rc;
> +
> +	if (!comm_buf)
> +		return EFI_INVALID_PARAMETER;
> +
> +	mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
> +	buf_size = mm_hdr->message_len + sizeof(efi_guid_t) + sizeof(size_t);
> +
> +	if (dsize != buf_size)
> +		return EFI_INVALID_PARAMETER;
> +
> +	shm = tee_shm_register_kernel_buf(pvt_data.ctx, comm_buf, buf_size);
> +	if (IS_ERR(shm)) {
> +		dev_err(pvt_data.dev, "Unable to register shared memory\n");
> +		return EFI_UNSUPPORTED;
> +	}
> +
> +	memset(&arg, 0, sizeof(arg));
> +	arg.func = PTA_STMM_CMD_COMMUNICATE;
> +	arg.session = pvt_data.session;
> +	arg.num_params = 4;
> +
> +	memset(param, 0, sizeof(param));
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT;
> +	param[0].u.memref.size = buf_size;
> +	param[0].u.memref.shm = shm;
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
> +	param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
> +	param[3].attr = TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
> +
> +	rc = tee_client_invoke_func(pvt_data.ctx, &arg, param);
> +	tee_shm_free(shm);
> +
> +	if (rc < 0 || arg.ret != 0) {
> +		dev_err(pvt_data.dev,
> +			"PTA_STMM_CMD_COMMUNICATE invoke error: 0x%x\n", arg.ret);
> +		return EFI_DEVICE_ERROR;
> +	}
> +
> +	switch (param[1].u.value.a) {
> +	case ARM_SVC_SPM_RET_SUCCESS:
> +		ret = EFI_SUCCESS;
> +		break;
> +
> +	case ARM_SVC_SPM_RET_INVALID_PARAMS:
> +		ret = EFI_INVALID_PARAMETER;
> +		break;
> +
> +	case ARM_SVC_SPM_RET_DENIED:
> +		ret = EFI_ACCESS_DENIED;
> +		break;
> +
> +	case ARM_SVC_SPM_RET_NO_MEMORY:
> +		ret = EFI_OUT_OF_RESOURCES;
> +		break;
> +
> +	default:
> +		ret = EFI_ACCESS_DENIED;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * mm_communicate() - Adjust the communication buffer to StandAlonneMM and send
> + * it to TEE
> + *
> + * @comm_buf:		locally allocated communication buffer, buffer should
> + *			be enough big to have some headers and payload
> + * @payload_size:	payload size
> + * Return:		status code
> + */
> +static efi_status_t mm_communicate(u8 *comm_buf, size_t payload_size)
> +{
> +	size_t dsize;
> +	efi_status_t ret;
> +	struct efi_mm_communicate_header *mm_hdr;
> +	struct smm_variable_communicate_header *var_hdr;
> +
> +	dsize = payload_size + MM_COMMUNICATE_HEADER_SIZE +
> +		MM_VARIABLE_COMMUNICATE_SIZE;
> +	mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
> +	var_hdr = (struct smm_variable_communicate_header *)mm_hdr->data;
> +
> +	ret = tee_mm_communicate(comm_buf, dsize);
> +	if (ret != EFI_SUCCESS) {
> +		dev_err(pvt_data.dev, "%s failed!\n", __func__);
> +		return ret;
> +	}
> +
> +	return var_hdr->ret_status;
> +}
> +
> +/**
> + * setup_mm_hdr() -	Allocate a buffer for StandAloneMM and initialize the
> + *			header data.
> + *
> + * @dptr:		pointer address to store allocated buffer
> + * @payload_size:	payload size
> + * @func:		standAloneMM function number
> + * @ret:		EFI return code
> + * Return:		pointer to corresponding StandAloneMM function buffer or NULL
> + */
> +static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func,
> +			  efi_status_t *ret)
> +{
> +	const efi_guid_t mm_var_guid = EFI_MM_VARIABLE_GUID;
> +	struct efi_mm_communicate_header *mm_hdr;
> +	struct smm_variable_communicate_header *var_hdr;
> +	u8 *comm_buf;
> +
> +	/* In the init function we initialize max_buffer_size with
> +	 * get_max_payload(). So skip the test if max_buffer_size is initialized
> +	 * StandAloneMM will perform similar checks and drop the buffer if it's
> +	 * too long
> +	 */
> +	if (max_buffer_size &&
> +	    max_buffer_size < (MM_COMMUNICATE_HEADER_SIZE +
> +			       MM_VARIABLE_COMMUNICATE_SIZE + payload_size)) {
> +		*ret = EFI_INVALID_PARAMETER;
> +		return NULL;
> +	}
> +
> +	comm_buf = kzalloc(MM_COMMUNICATE_HEADER_SIZE +
> +				   MM_VARIABLE_COMMUNICATE_SIZE + payload_size,
> +			   GFP_KERNEL);
> +	if (!comm_buf) {
> +		*ret = EFI_OUT_OF_RESOURCES;
> +		return NULL;
> +	}
> +
> +	mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
> +	memcpy(&mm_hdr->header_guid, &mm_var_guid, sizeof(mm_hdr->header_guid));
> +	mm_hdr->message_len = MM_VARIABLE_COMMUNICATE_SIZE + payload_size;
> +
> +	var_hdr = (struct smm_variable_communicate_header *)mm_hdr->data;
> +	var_hdr->function = func;
> +	if (dptr)
> +		*dptr = comm_buf;
> +	*ret = EFI_SUCCESS;
> +
> +	return var_hdr->data;
> +}
> +
> +/**
> + * get_max_payload() - Get variable payload size from StandAloneMM.
> + *
> + * @size:    size of the variable in storage
> + * Return:   status code
> + */
> +static efi_status_t get_max_payload(size_t *size)
> +{
> +	struct smm_variable_payload_size *var_payload = NULL;
> +	size_t payload_size;
> +	u8 *comm_buf = NULL;
> +	efi_status_t ret;
> +
> +	if (!size) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	payload_size = sizeof(*var_payload);
> +	var_payload = setup_mm_hdr(&comm_buf, payload_size,
> +				   SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE,
> +				   &ret);
> +	if (!comm_buf)
> +		goto out;
> +
> +	ret = mm_communicate(comm_buf, payload_size);
> +	if (ret != EFI_SUCCESS)
> +		goto out;
> +
> +	/* Make sure the buffer is big enough for storing variables */
> +	if (var_payload->size < MM_VARIABLE_ACCESS_HEADER_SIZE + 0x20) {
> +		ret = EFI_DEVICE_ERROR;
> +		goto out;
> +	}
> +	*size = var_payload->size;
> +	/*
> +	 * There seems to be a bug in EDK2 miscalculating the boundaries and
> +	 * size checks, so deduct 2 more bytes to fulfill this requirement. Fix
> +	 * it up here to ensure backwards compatibility with older versions
> +	 * (cf. StandaloneMmPkg/Drivers/StandaloneMmCpu/AArch64/EventHandle.c.
> +	 * sizeof (EFI_MM_COMMUNICATE_HEADER) instead the size minus the
> +	 * flexible array member).
> +	 *
> +	 * size is guaranteed to be > 2 due to checks on the beginning.
> +	 */
> +	*size -= 2;
> +out:
> +	kfree(comm_buf);
> +	return ret;
> +}
> +
> +static efi_status_t get_property_int(u16 *name, size_t name_size,
> +				     const efi_guid_t *vendor,
> +				     struct var_check_property *var_property)
> +{
> +	struct smm_variable_var_check_property *smm_property;
> +	size_t payload_size;
> +	u8 *comm_buf = NULL;
> +	efi_status_t ret;
> +
> +	memset(var_property, 0, sizeof(*var_property));
> +	payload_size = sizeof(*smm_property) + name_size;
> +	if (payload_size > max_payload_size) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +	smm_property = setup_mm_hdr(
> +		&comm_buf, payload_size,
> +		SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET, &ret);
> +	if (!comm_buf)
> +		goto out;
> +
> +	memcpy(&smm_property->guid, vendor, sizeof(smm_property->guid));
> +	smm_property->name_size = name_size;
> +	memcpy(smm_property->name, name, name_size);
> +
> +	ret = mm_communicate(comm_buf, payload_size);
> +	/*
> +	 * Currently only R/O property is supported in StMM.
> +	 * Variables that are not set to R/O will not set the property in StMM
> +	 * and the call will return EFI_NOT_FOUND. We are setting the
> +	 * properties to 0x0 so checking against that is enough for the
> +	 * EFI_NOT_FOUND case.
> +	 */
> +	if (ret == EFI_NOT_FOUND)
> +		ret = EFI_SUCCESS;
> +	if (ret != EFI_SUCCESS)
> +		goto out;
> +	memcpy(var_property, &smm_property->property, sizeof(*var_property));
> +
> +out:
> +	kfree(comm_buf);
> +	return ret;
> +}
> +
> +static efi_status_t tee_get_variable(u16 *name, efi_guid_t *vendor,
> +				     u32 *attributes, unsigned long *data_size,
> +				     void *data)
> +{
> +	struct var_check_property var_property;
> +	struct smm_variable_access *var_acc;
> +	size_t payload_size;
> +	size_t name_size;
> +	size_t tmp_dsize;
> +	u8 *comm_buf = NULL;
> +	efi_status_t ret;
> +
> +	if (!name || !vendor || !data_size) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	name_size = (ucs2_strnlen(name, EFI_VAR_NAME_LEN) + 1) * sizeof(u16);
> +	if (name_size > max_payload_size - MM_VARIABLE_ACCESS_HEADER_SIZE) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	/* Trim output buffer size */
> +	tmp_dsize = *data_size;
> +	if (name_size + tmp_dsize >
> +	    max_payload_size - MM_VARIABLE_ACCESS_HEADER_SIZE) {
> +		tmp_dsize = max_payload_size - MM_VARIABLE_ACCESS_HEADER_SIZE -
> +			    name_size;
> +	}
> +
> +	/* Get communication buffer and initialize header */
> +	payload_size = MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + tmp_dsize;
> +	var_acc = setup_mm_hdr(&comm_buf, payload_size,
> +			       SMM_VARIABLE_FUNCTION_GET_VARIABLE, &ret);
> +	if (!comm_buf)
> +		goto out;
> +
> +	/* Fill in contents */
> +	memcpy(&var_acc->guid, vendor, sizeof(var_acc->guid));
> +	var_acc->data_size = tmp_dsize;
> +	var_acc->name_size = name_size;
> +	var_acc->attr = attributes ? *attributes : 0;
> +	memcpy(var_acc->name, name, name_size);
> +
> +	/* Communicate */
> +	ret = mm_communicate(comm_buf, payload_size);
> +	if (ret == EFI_SUCCESS || ret == EFI_BUFFER_TOO_SMALL)
> +		/* Update with reported data size for trimmed case */
> +		*data_size = var_acc->data_size;
> +	if (ret != EFI_SUCCESS)
> +		goto out;
> +
> +	ret = get_property_int(name, name_size, vendor, &var_property);
> +	if (ret != EFI_SUCCESS)
> +		goto out;
> +
> +	if (attributes)
> +		*attributes = var_acc->attr;
> +
> +	if (data)
> +		memcpy(data, (u8 *)var_acc->name + var_acc->name_size,
> +		       var_acc->data_size);
> +	else
> +		ret = EFI_INVALID_PARAMETER;
> +
> +out:
> +	kfree(comm_buf);
> +	return ret;
> +}
> +
> +static efi_status_t tee_get_next_variable(unsigned long *name_size,
> +					  efi_char16_t *name, efi_guid_t *guid)
> +{
> +	struct smm_variable_getnext *var_getnext;
> +	size_t payload_size;
> +	size_t out_name_size;
> +	size_t in_name_size;
> +	u8 *comm_buf = NULL;
> +	efi_status_t ret;
> +
> +	if (!name_size || !name || !guid) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	out_name_size = *name_size;
> +	in_name_size = (ucs2_strnlen(name, EFI_VAR_NAME_LEN) + 1) * sizeof(u16);
> +
> +	if (out_name_size < in_name_size) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	if (in_name_size >
> +	    max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	/* Trim output buffer size */
> +	if (out_name_size > max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE)
> +		out_name_size =
> +			max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE;
> +
> +	payload_size = MM_VARIABLE_GET_NEXT_HEADER_SIZE + out_name_size;
> +	var_getnext = setup_mm_hdr(&comm_buf, payload_size,
> +				   SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME,
> +				   &ret);
> +	if (!comm_buf)
> +		goto out;
> +
> +	/* Fill in contents */
> +	memcpy(&var_getnext->guid, guid, sizeof(var_getnext->guid));
> +	var_getnext->name_size = out_name_size;
> +	memcpy(var_getnext->name, name, in_name_size);
> +	memset((u8 *)var_getnext->name + in_name_size, 0x0,
> +	       out_name_size - in_name_size);
> +
> +	/* Communicate */
> +	ret = mm_communicate(comm_buf, payload_size);
> +	if (ret == EFI_SUCCESS || ret == EFI_BUFFER_TOO_SMALL) {
> +		/* Update with reported data size for trimmed case */
> +		*name_size = var_getnext->name_size;
> +	}
> +	if (ret != EFI_SUCCESS)
> +		goto out;
> +
> +	memcpy(guid, &var_getnext->guid, sizeof(*guid));
> +	memcpy(name, var_getnext->name, var_getnext->name_size);
> +
> +out:
> +	kfree(comm_buf);
> +	return ret;
> +}
> +
> +static efi_status_t tee_set_variable(efi_char16_t *name, efi_guid_t *vendor,
> +				     u32 attributes, unsigned long data_size,
> +				     void *data)
> +{
> +	efi_status_t ret;
> +	struct var_check_property var_property;
> +	struct smm_variable_access *var_acc;
> +	size_t payload_size;
> +	size_t name_size;
> +	u8 *comm_buf = NULL;
> +
> +	if (!name || name[0] == 0 || !vendor) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +	if (data_size > 0 && !data) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +	/* Check payload size */
> +	name_size = (ucs2_strnlen(name, EFI_VAR_NAME_LEN) + 1) * sizeof(u16);
> +	payload_size = MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + data_size;
> +	if (payload_size > max_payload_size) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Allocate the buffer early, before switching to RW (if needed)
> +	 * so we won't need to account for any failures in reading/setting
> +	 * the properties, if the allocation fails
> +	 */
> +	var_acc = setup_mm_hdr(&comm_buf, payload_size,
> +			       SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
> +	if (!comm_buf)
> +		goto out;
> +
> +	/*
> +	 * The API has the ability to override RO flags. If no RO check was
> +	 * requested switch the variable to RW for the duration of this call
> +	 */
> +	ret = get_property_int(name, name_size, vendor, &var_property);
> +	if (ret != EFI_SUCCESS) {
> +		dev_err(pvt_data.dev, "Getting variable property failed\n");
> +		goto out;
> +	}
> +
> +	if (var_property.property & VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY) {
> +		ret = EFI_WRITE_PROTECTED;
> +		goto out;
> +	}
> +
> +	/* Fill in contents */
> +	memcpy(&var_acc->guid, vendor, sizeof(var_acc->guid));
> +	var_acc->data_size = data_size;
> +	var_acc->name_size = name_size;
> +	var_acc->attr = attributes;
> +	memcpy(var_acc->name, name, name_size);
> +	memcpy((u8 *)var_acc->name + name_size, data, data_size);
> +
> +
> +	/* Communicate */
> +	ret = mm_communicate(comm_buf, payload_size);
> +	dev_dbg(pvt_data.dev, "Set Variable %s %d %lx\n", __FILE__, __LINE__, ret);
> +out:
> +	kfree(comm_buf);
> +	return ret;
> +}
> +
> +static efi_status_t tee_set_variable_nonblocking(efi_char16_t *name,
> +						 efi_guid_t *vendor,
> +						 u32 attributes,
> +						 unsigned long data_size,
> +						 void *data)
> +{
> +	return EFI_UNSUPPORTED;
> +}
> +
> +static efi_status_t tee_query_variable_info(u32 attributes,
> +					    u64 *max_variable_storage_size,
> +					    u64 *remain_variable_storage_size,
> +					    u64 *max_variable_size)
> +{
> +	struct smm_variable_query_info *mm_query_info;
> +	size_t payload_size;
> +	efi_status_t ret;
> +	u8 *comm_buf;
> +
> +	payload_size = sizeof(*mm_query_info);
> +	mm_query_info = setup_mm_hdr(&comm_buf, payload_size,
> +				SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO,
> +				&ret);
> +	if (!comm_buf)
> +		goto out;
> +
> +	mm_query_info->attr = attributes;
> +	ret = mm_communicate(comm_buf, payload_size);
> +	if (ret != EFI_SUCCESS)
> +		goto out;
> +	*max_variable_storage_size = mm_query_info->max_variable_storage;
> +	*remain_variable_storage_size =
> +		mm_query_info->remaining_variable_storage;
> +	*max_variable_size = mm_query_info->max_variable_size;
> +
> +out:
> +	kfree(comm_buf);
> +	return ret;
> +}
> +
> +static int tee_stmm_efi_probe(struct device *dev)
> +{
> +	struct tee_ioctl_open_session_arg sess_arg;
> +	efi_status_t ret;
> +	int rc;
> +
> +	/* Open context with TEE driver */
> +	pvt_data.ctx = tee_client_open_context(NULL, tee_ctx_match, NULL, NULL);
> +	if (IS_ERR(pvt_data.ctx))
> +		return -ENODEV;
> +
> +	/* Open session with StMM PTA */
> +	memset(&sess_arg, 0, sizeof(sess_arg));
> +	export_uuid(sess_arg.uuid, &tee_stmm_efi_id_table[0].uuid);
> +	rc = tee_client_open_session(pvt_data.ctx, &sess_arg, NULL);
> +	if ((rc < 0) || (sess_arg.ret != 0)) {
> +		dev_err(dev, "tee_client_open_session failed, err: %x\n",
> +			sess_arg.ret);
> +		rc = -EINVAL;
> +		goto out_ctx;
> +	}
> +	pvt_data.session = sess_arg.session;
> +	pvt_data.dev = dev;
> +
> +	ret = get_max_payload(&max_payload_size);
> +	if (ret != EFI_SUCCESS) {
> +		rc = -EIO;
> +		goto out_sess;
> +	}
> +
> +	max_buffer_size = MM_COMMUNICATE_HEADER_SIZE +
> +			  MM_VARIABLE_COMMUNICATE_SIZE +
> +			  max_payload_size;
> +
> +	tee_efivar_ops.get_variable = tee_get_variable;
> +	tee_efivar_ops.get_next_variable = tee_get_next_variable;
> +	tee_efivar_ops.set_variable = tee_set_variable;
> +	tee_efivar_ops.set_variable_nonblocking = tee_set_variable_nonblocking;
> +	tee_efivar_ops.query_variable_store = efi_query_variable_store;
> +	tee_efivar_ops.query_variable_info = tee_query_variable_info;
> +
> +	efivars_generic_ops_unregister();
> +	pr_info("Use tee-based EFI runtime variable services\n");
> +	efivars_register(&tee_efivars, &tee_efivar_ops);
> +
> +	return 0;
> +
> +out_sess:
> +	tee_client_close_session(pvt_data.ctx, pvt_data.session);
> +out_ctx:
> +	tee_client_close_context(pvt_data.ctx);
> +
> +	return rc;
> +}
> +
> +static int tee_stmm_efi_remove(struct device *dev)
> +{
> +	efivars_unregister(&tee_efivars);
> +	efivars_generic_ops_register();
> +
> +	tee_client_close_session(pvt_data.ctx, pvt_data.session);
> +	tee_client_close_context(pvt_data.ctx);
> +
> +	return 0;
> +}
> +
> +MODULE_DEVICE_TABLE(tee, tee_stmm_efi_id_table);
> +
> +static struct tee_client_driver tee_stmm_efi_driver = {
> +	.id_table	= tee_stmm_efi_id_table,
> +	.driver		= {
> +		.name		= "tee-stmm-efi",
> +		.bus		= &tee_bus_type,
> +		.probe		= tee_stmm_efi_probe,
> +		.remove		= tee_stmm_efi_remove,
> +	},
> +};
> +
> +static int __init tee_stmm_efi_mod_init(void)
> +{
> +	return driver_register(&tee_stmm_efi_driver.driver);
> +}
> +
> +static void __exit tee_stmm_efi_mod_exit(void)
> +{
> +	driver_unregister(&tee_stmm_efi_driver.driver);
> +}
> +
> +module_init(tee_stmm_efi_mod_init);
> +module_exit(tee_stmm_efi_mod_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Ilias Apalodimas <ilias.apalodimas@linaro.org>");
> +MODULE_AUTHOR("Masahisa Kojima <masahisa.kojima@linaro.org>");
> +MODULE_DESCRIPTION("TEE based EFI runtime variable service driver");

I think we have a probe ordering issue with this driver:
efivarfs_fill_super() may be called before the TEE bus was probed, thus
with the default efivar ops still registered. And that means
efivar_supports_writes() will return false, and the fs declares itself
as readonly. I've seen systemd mounting it r/o initialling, and you need
to remount the fs to enable writability.

Is there anything that could be done to re-order things reliably, probe
the tee bus earlier etc.?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

