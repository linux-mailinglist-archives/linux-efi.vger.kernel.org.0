Return-Path: <linux-efi+bounces-2162-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871FE9CF24B
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 18:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA971F21092
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 17:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5949115C15E;
	Fri, 15 Nov 2024 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tn4akfEV"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF16558BB;
	Fri, 15 Nov 2024 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731690141; cv=none; b=Dy0/6naaSRZWohjdFVetd1qRTb2We5P1aGW8gTBiZgkib5b1OcaOFmPscJCq4/ho2gy54p59NIaXor1rwvw8iqVH9sVBKZT2Y9hl9xerFt0b3Kqhk+5r7QGiib8tskVnMTjBGorXUGGmPknJGwycs25YfGseVt+UpoK9+HddjPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731690141; c=relaxed/simple;
	bh=3txChuxb2FgIOc2ar5fiDhSZp5OI4cSfiC+btm7Sw6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lak2+nxBmkiKr0eNN9OY2ED3l1aVvsbTuNAqsmTrsKAGnMUR/kvlO/VAPgrBQalE5wYAf2FWOGGN9e5M3R3cHuphJ8tj1/kEe3u1yiKLB5aMZ4Y8c/shbhZCsSQcZDdkMZOIP03Zj7vSH+e9yR1HIxtJ9TXCCfGdpK4fjLAXZDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tn4akfEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF280C4CECF;
	Fri, 15 Nov 2024 17:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731690139;
	bh=3txChuxb2FgIOc2ar5fiDhSZp5OI4cSfiC+btm7Sw6Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Tn4akfEV/3Pjb5eV9kmast/UbydSLSJ4nA9q6HVmlYVzuxNoKqAGbdYwSAAhrLEb2
	 3xZyFabtN9kOMz5aG+wEpnVPjx1/hvBuRQZLUmiL7jF5/cxrgK77dfqNTwG8mM4VQ3
	 tcejpXBd3GIuGSO9ghgPOP9TQ5XM/JDVo3LpiuC7dOjsS6ykRgQ4ZOe4P2OyCIQUdJ
	 D49rI65MptlxZ3RpXFkL3SfvcQQW8rpB7DTQQQXzvOEkP24h0Rp0GWCiS4Y60/2a2F
	 hs5owwuXhPBeBp3qWdsBSEo217JmibK2HC44W0O8EY+79ycwuXLLzCryJyL0A48yTq
	 mIx8fn09c8ERQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so18316011fa.2;
        Fri, 15 Nov 2024 09:02:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUp81sIA5b5OaGc2KE2eHMXDN3voe6hQUYuOFlBiPuwTk9bmHsQWGPzQLWN01CwSFa7DtvCXlBqvig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbiJdk367X2oQ0wMiHKcP1Z4o+VoAwdnP/KOxtOkRXlgo+biq/
	VedJplKVgDLLzmuMf0LxTUFYsN2KUoHHR4FuONq6zpQnwVREWG7LAwmvJWlv00XinlI6A/9H+Xe
	Tpd1uWUgUARPsDvBumXm/3n3ty5s=
X-Google-Smtp-Source: AGHT+IF+bn6lQVsV9JHm431U6oqIpcRAhQAC2udhvS++3ivuiWPWYBh/3DUt4ctADgmhM2HVsc9ybhQYPsRrp+tuDuk=
X-Received: by 2002:a2e:bc22:0:b0:2fa:ce00:3689 with SMTP id
 38308e7fff4ca-2ff60621cfcmr22308601fa.6.1731690138028; Fri, 15 Nov 2024
 09:02:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZyizcvscUWIyZYdE@grain> <Zyi11v-6V_ivKS5x@grain> <Zyi6g8W0OqKcng6S@grain>
In-Reply-To: <Zyi6g8W0OqKcng6S@grain>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Nov 2024 18:02:07 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEujWSOLjtwqSrmeP8yxuYof_Vn-vPVFi+gA2m=p64sEw@mail.gmail.com>
Message-ID: <CAMj1kXEujWSOLjtwqSrmeP8yxuYof_Vn-vPVFi+gA2m=p64sEw@mail.gmail.com>
Subject: Re: [PATCH v2] efi: Fix memory leak in efivar_ssdt_load
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Nov 2024 at 13:14, Cyrill Gorcunov <gorcunov@gmail.com> wrote:
>
> When we load ssdt from efi variable (specified with efivar_ssdt=something
> boot command line argument) a name for the variable is allocated
> dynamically because we traverse all efi variables. Unlike an acpi table
> data, which is later used by acpi engine, the name is no longer needed
> once traverse is complete -- don't forget to free this memory.
>
> Same time we silently ignore any errors happened here lets print
> a message if something went wrong (but do not exit since this is
> not a critical error and the system should continue to boot).
>
> Also while here -- add a note why we keep ssdt table on success.
>
> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> ---
> It is still unclear for me why we don't exit with error if acpi_load_table
> failed but continue to iterate keys and don't report a caller with error
> instead. I didn't change this logic for backward compatibility sake but
> still looks suspicious.
>

I've queued this up now.

I think there may be cases where it might make sense, or at least,
where currently, we might rely on the behavior where acpi_load_table()
failures are ignored. If a table references an object that does not
exist in the namespace (e.g., because some I2C controller is
disabled), it might still make sense to load remaining SSDTs if they
describe things that are unrelated.

But frankly, I think this is a very niche feature, and I'm not sure
supporting more than one table is that useful to begin with. You can
always merge SSDTs into a single one if needed (and things like this
are not the job of the OS imho)


>  drivers/firmware/efi/efi.c |   41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
>
> Index: linux-tip.git/drivers/firmware/efi/efi.c
> ===================================================================
> --- linux-tip.git.orig/drivers/firmware/efi/efi.c
> +++ linux-tip.git/drivers/firmware/efi/efi.c
> @@ -273,6 +273,7 @@ static __init int efivar_ssdt_load(void)
>         efi_char16_t *name = NULL;
>         efi_status_t status;
>         efi_guid_t guid;
> +       int ret = 0;
>
>         if (!efivar_ssdt[0])
>                 return 0;
> @@ -294,8 +295,8 @@ static __init int efivar_ssdt_load(void)
>                         efi_char16_t *name_tmp =
>                                 krealloc(name, name_size, GFP_KERNEL);
>                         if (!name_tmp) {
> -                               kfree(name);
> -                               return -ENOMEM;
> +                               ret = -ENOMEM;
> +                               goto out;
>                         }
>                         name = name_tmp;
>                         continue;
> @@ -309,26 +310,38 @@ static __init int efivar_ssdt_load(void)
>                 pr_info("loading SSDT from variable %s-%pUl\n", efivar_ssdt, &guid);
>
>                 status = efi.get_variable(name, &guid, NULL, &data_size, NULL);
> -               if (status != EFI_BUFFER_TOO_SMALL || !data_size)
> -                       return -EIO;
> +               if (status != EFI_BUFFER_TOO_SMALL || !data_size) {
> +                       ret = -EIO;
> +                       goto out;
> +               }
>
>                 data = kmalloc(data_size, GFP_KERNEL);
> -               if (!data)
> -                       return -ENOMEM;
> +               if (!data) {
> +                       ret = -ENOMEM;
> +                       goto out;
> +               }
>
>                 status = efi.get_variable(name, &guid, NULL, &data_size, data);
>                 if (status == EFI_SUCCESS) {
> -                       acpi_status ret = acpi_load_table(data, NULL);
> -                       if (ret)
> -                               pr_err("failed to load table: %u\n", ret);
> -                       else
> +                       acpi_status acpi_ret = acpi_load_table(data, NULL);
> +                       if (ACPI_FAILURE(acpi_ret)) {
> +                               pr_err("efivar_ssdt: failed to load table: %u\n",
> +                                      acpi_ret);
> +                       } else {
> +                               /*
> +                                * The @data will be in use by ACPI engine,
> +                                * do not free it!
> +                                */
>                                 continue;
> +                       }
>                 } else {
> -                       pr_err("failed to get var data: 0x%lx\n", status);
> +                       pr_err("efivar_ssdt: failed to get var data: 0x%lx\n", status);
>                 }
>                 kfree(data);
>         }
> -       return 0;
> +out:
> +       kfree(name);
> +       return ret;
>  }
>  #else
>  static inline int efivar_ssdt_load(void) { return 0; }
> @@ -433,7 +446,9 @@ static int __init efisubsys_init(void)
>                 error = generic_ops_register();
>                 if (error)
>                         goto err_put;
> -               efivar_ssdt_load();
> +               error = efivar_ssdt_load();
> +               if (error)
> +                       pr_err("efi: failed to load SSDT, error %d.\n", error);
>                 platform_device_register_simple("efivars", 0, NULL, 0);
>         }
>
>

