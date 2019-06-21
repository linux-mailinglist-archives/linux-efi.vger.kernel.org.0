Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B724D4ECC7
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2019 18:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfFUQEg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Jun 2019 12:04:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46229 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfFUQEg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Jun 2019 12:04:36 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so374075iol.13
        for <linux-efi@vger.kernel.org>; Fri, 21 Jun 2019 09:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ejO6YtCvs3BDmGjvFHcbczpLYASEeeFQ3WnZFBfg3A0=;
        b=puXlInJJGRkxBXpVtJaDZIB48ih7MQP0NV2/owmzo+yO05n7PRpK/IuBXRTdRMXgJ0
         t0EZ3KWUfPI9YiGYaX7R4dCzI7qcdhVaqwLuwAGhgj3k5nlv+9q0ki+yfROUxgZqXMWe
         Pa0TRH4rEjxzv7D/ehGGPwuMNbixMty9hONt/JSFmDtdf7JPmrg6qdanYTCe5V0KaYYV
         PMZvyeLkIkJxEXYHac22Mu9l722zEA3QS0tVsnfwtkpyr5enfyTlyZdGlLSwIED2VkS6
         eP2/s3276wGKTUP0mcPCoRgNf7j/GwIsoNqZ1iZqF/84RdA6Fr2+IO4neTbzbKqZh4zm
         weWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ejO6YtCvs3BDmGjvFHcbczpLYASEeeFQ3WnZFBfg3A0=;
        b=lKRryESTNHrXQPlWuWtJPpZn1q9ih4Pu6iaHvEQPKKIoQ2AmXuGT4SCMQeD+a+rIcz
         1dXAJQk2l8A2K2Q+VTwqxD1GixM7IA/DKgh8TpjHbrAAG8MNzhccZ03Mw9+gNHNfcVeN
         ZSqgajbtf/Oh1PVQfORRuK+WFPqWZG3JzRcgfDxq7eaOKDr67K/Jk2WiZt6b9lCxPlmy
         jq1aODqf8OYUwjk4p+oyy4zSlZJf88OluSO+Oqqy01hDZn4Xd66hB2iE8P2BHO9eEFPl
         eSs+hEijmK1660UVUS6Yzf9C+BqObZCYufAut96+6Hy4pyxF2nessv18mbRfSepPZg6Q
         IXMQ==
X-Gm-Message-State: APjAAAW9uXz+CaEAACaQ3MKypN1toQLensXZvVsOjY54u+I9ShXSCNAV
        YIN64VTlPKKYpG/Mb9xY6d2ZPSm6OXBXD4h5Jr2/xA==
X-Google-Smtp-Source: APXvYqxPd7JAgsmP+R/behWLQauzRgLAyXsntBayfTLa74mpjJhuEP933fxdwKZ0rjPbZarLl47D0PXEJiJNMoaoSK0=
X-Received: by 2002:a5d:9d97:: with SMTP id 23mr26202514ion.204.1561133075227;
 Fri, 21 Jun 2019 09:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190612081810.26526-1-baofeng.tian@intel.com>
In-Reply-To: <20190612081810.26526-1-baofeng.tian@intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 21 Jun 2019 18:04:24 +0200
Message-ID: <CAKv+Gu-QVW8eV3dvAYsRF6HAdmczd6ymW5_8aWBuFpVqfrsJ7A@mail.gmail.com>
Subject: Re: [[efi boot control]] efibc: Replace variable set function in
 notifier call
To:     baofeng.tian@intel.com
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        jeremy.compostella@intel.com, ming.tan@intel.com,
        qihua.zhuang@intel.com, Luo XinanX <xinanx.luo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 12 Jun 2019 at 10:20, <baofeng.tian@intel.com> wrote:
>
> From: Tian Baofeng <baofeng.tian@intel.com>
>
> Replace the variable set function from "efivar_entry_set" to
> "efivar_entry_set_safe" in efibc panic notifier.
> In safe function parameter "block" will set to false
> and will call "efivar_entry_set_nonblocking"to set efi variables.
> efivar_entry_set_nonblocking is guaranteed to
> not block and is suitable for calling from crash/panic handlers.
> In UEFI android platform, when warm reset happens,
> with this change, efibc will not block the reboot process.
> Otherwise, set variable will call queue work and send to other offlined
> cpus then cause another panic, finally will cause reboot failure.
>
> Signed-off-by: Tian Baofeng <baofeng.tian@intel.com>
> Signed-off-by: Luo XinanX <xinanx.luo@intel.com>

Queued as a fix in efi/urgent

Thanks

> ---
>  drivers/firmware/efi/efibc.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/firmware/efi/efibc.c b/drivers/firmware/efi/efibc.c
> index 61e099826cbb..35dccc88ac0a 100644
> --- a/drivers/firmware/efi/efibc.c
> +++ b/drivers/firmware/efi/efibc.c
> @@ -43,11 +43,13 @@ static int efibc_set_variable(const char *name, const char *value)
>         efibc_str_to_str16(value, (efi_char16_t *)entry->var.Data);
>         memcpy(&entry->var.VendorGuid, &guid, sizeof(guid));
>
> -       ret = efivar_entry_set(entry,
> -                              EFI_VARIABLE_NON_VOLATILE
> -                              | EFI_VARIABLE_BOOTSERVICE_ACCESS
> -                              | EFI_VARIABLE_RUNTIME_ACCESS,
> -                              size, entry->var.Data, NULL);
> +       ret = efivar_entry_set_safe(entry->var.VariableName,
> +                                   entry->var.VendorGuid,
> +                                   EFI_VARIABLE_NON_VOLATILE
> +                                   | EFI_VARIABLE_BOOTSERVICE_ACCESS
> +                                   | EFI_VARIABLE_RUNTIME_ACCESS,
> +                                   false, size, entry->var.Data);
> +
>         if (ret)
>                 pr_err("failed to set %s EFI variable: 0x%x\n",
>                        name, ret);
> --
> 2.21.0
>
