Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C541D77FD58
	for <lists+linux-efi@lfdr.de>; Thu, 17 Aug 2023 19:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244294AbjHQRzf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Thu, 17 Aug 2023 13:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354176AbjHQRzU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 17 Aug 2023 13:55:20 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B15E19A1;
        Thu, 17 Aug 2023 10:55:18 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-56d75fb64a6so23225eaf.0;
        Thu, 17 Aug 2023 10:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692294918; x=1692899718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkeXSFZ/OrSsfFrmnxtdMYT0Ke6K2z+mrhEthcE11s0=;
        b=AOkDmJ/rJXAfiCqAox7kQvivv/Od5z3t93aTMtlXGTJWoMKCfM8B6w2b0T42vvE6P/
         tLfU2MhCngeUlobsjjns75uRtYnBz9F7/dtERN6Z0jAXWIvOvH4gtf7Cn9n+C1JNCyze
         5D0HQBFBorNjyJoWs1ZZp6e2tjzTdNOzLyusOpEjgWzWsuDWcflbbQymyr7pMyxbatSy
         DXsrQ/xBB9QDYDRKZDMIAecJq5ZPgHn/HFvn5+/uqg00xY2Awo42pXoiEQOrXF+2lFYs
         lHIJFzjSvb8G6djUmkf7QTOO32zQ+VWIPwmB9VU+jS7vugT0J3FP5Q0WUVVgczKlv75B
         hNCA==
X-Gm-Message-State: AOJu0YwzFL1tNHenfUPxSRAgqZBvaUuYr+IQBypkBPTej306V3oyDlad
        CY+LspEJvl0S9jIjN+bsRCPT235wU7KVMw+xZsq9Gb8d
X-Google-Smtp-Source: AGHT+IEe4KFtf4SD0b0JnBWjy7imQS8O1fvEl7d8K1Jy69Vav7C3PGzDsQc/T2kpFV2V7wf2AN8QzRJ33gqF4S2fPxU=
X-Received: by 2002:a4a:eb1a:0:b0:560:b01a:653d with SMTP id
 f26-20020a4aeb1a000000b00560b01a653dmr554749ooj.0.1692294917755; Thu, 17 Aug
 2023 10:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230804160359.228901-1-ardb@kernel.org> <20230804160359.228901-5-ardb@kernel.org>
In-Reply-To: <20230804160359.228901-5-ardb@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Aug 2023 19:55:06 +0200
Message-ID: <CAJZ5v0go8BOLQSsb6G-yybsxt9Siq2D2wbOrhvdmU_TvaG0VhA@mail.gmail.com>
Subject: Re: [PATCH 4/4] acpi/prmt: Use EFI runtime sandbox to invoke PRM handlers
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org, lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 4, 2023 at 6:04 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Instead of bypassing the kernel's adaptation layer for performing EFI
> runtime calls, wire up ACPI PRM handling into it. This means these calls
> can no longer occur concurrently with EFI runtime calls, and will be
> made from the EFI runtime workqueue. It also means any page faults
> occurring during PRM handling will be identified correctly as
> originating in firmware code.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!

> ---
>  drivers/acpi/prmt.c                     |  8 ++++----
>  drivers/firmware/efi/runtime-wrappers.c | 20 ++++++++++++++++++++
>  include/linux/efi.h                     | 13 +++++++++++++
>  3 files changed, 37 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index 3d4c4620f9f95309..95be1c80db387faa 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -53,7 +53,7 @@ static LIST_HEAD(prm_module_list);
>
>  struct prm_handler_info {
>         guid_t guid;
> -       void *handler_addr;
> +       efi_acpi_prm_handler_t *handler_addr;
>         u64 static_data_buffer_addr;
>         u64 acpi_param_buffer_addr;
>
> @@ -260,9 +260,9 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
>                 context.static_data_buffer = handler->static_data_buffer_addr;
>                 context.mmio_ranges = module->mmio_info;
>
> -               status = efi_call_virt_pointer(handler, handler_addr,
> -                                              handler->acpi_param_buffer_addr,
> -                                              &context);
> +               status = efi_call_acpi_prm_handler(handler->handler_addr,
> +                                                  handler->acpi_param_buffer_addr,
> +                                                  &context);
>                 if (status == EFI_SUCCESS) {
>                         buffer->prm_status = PRM_HANDLER_SUCCESS;
>                 } else {
> diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
> index b3ef208299ae591e..ce306cd1efdfda21 100644
> --- a/drivers/firmware/efi/runtime-wrappers.c
> +++ b/drivers/firmware/efi/runtime-wrappers.c
> @@ -212,6 +212,12 @@ static void efi_call_rts(struct work_struct *work)
>                                        efi_rts_work.QUERY_CAPSULE_CAPS.max_size,
>                                        efi_rts_work.QUERY_CAPSULE_CAPS.reset_type);
>                 break;
> +       case EFI_ACPI_PRM_HANDLER:
> +               status = efi_call_virt_pointer(&efi_rts_work.ACPI_PRM_HANDLER,
> +                                              handler_addr,
> +                                              efi_rts_work.ACPI_PRM_HANDLER.param_buffer_addr,
> +                                              efi_rts_work.ACPI_PRM_HANDLER.context);
> +               break;
>         default:
>                 /*
>                  * Ideally, we should never reach here because a caller of this
> @@ -475,3 +481,17 @@ void __init efi_native_runtime_setup(void)
>         efi.update_capsule = virt_efi_update_capsule;
>         efi.query_capsule_caps = virt_efi_query_capsule_caps;
>  }
> +
> +efi_status_t efi_call_acpi_prm_handler(efi_acpi_prm_handler_t *handler_addr,
> +                                      efi_physical_addr_t param_buffer_addr,
> +                                      void *context)
> +{
> +       efi_status_t status;
> +
> +       if (down_interruptible(&efi_runtime_lock))
> +               return EFI_ABORTED;
> +       status = efi_queue_work(ACPI_PRM_HANDLER, handler_addr,
> +                               param_buffer_addr, context);
> +       up(&efi_runtime_lock);
> +       return status;
> +}
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index c72715821016851b..065af735d90a411c 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1230,6 +1230,12 @@ extern int efi_tpm_final_log_size;
>
>  extern unsigned long rci2_table_phys;
>
> +typedef efi_status_t (__efiapi efi_acpi_prm_handler_t)(efi_physical_addr_t, void *);
> +
> +efi_status_t efi_call_acpi_prm_handler(efi_acpi_prm_handler_t *handler_addr,
> +                                      efi_physical_addr_t param_buffer_addr,
> +                                      void *context);
> +
>  /*
>   * efi_runtime_service() function identifiers.
>   * "NONE" is used by efi_recover_from_page_fault() to check if the page
> @@ -1249,6 +1255,7 @@ enum efi_rts_ids {
>         EFI_RESET_SYSTEM,
>         EFI_UPDATE_CAPSULE,
>         EFI_QUERY_CAPSULE_CAPS,
> +       EFI_ACPI_PRM_HANDLER,
>  };
>
>  /*
> @@ -1324,6 +1331,12 @@ struct efi_runtime_work {
>                         u64             *max_size;
>                         int             *reset_type;
>                 } QUERY_CAPSULE_CAPS;
> +
> +               struct {
> +                       efi_acpi_prm_handler_t  *handler_addr;
> +                       efi_physical_addr_t     param_buffer_addr;
> +                       void                    *context;
> +               } ACPI_PRM_HANDLER;
>         };
>         efi_status_t status;
>         struct work_struct work;
> --
> 2.39.2
>
