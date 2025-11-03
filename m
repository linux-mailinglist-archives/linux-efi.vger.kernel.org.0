Return-Path: <linux-efi+bounces-5331-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BF4C2A88E
	for <lists+linux-efi@lfdr.de>; Mon, 03 Nov 2025 09:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0441D4E2F1D
	for <lists+linux-efi@lfdr.de>; Mon,  3 Nov 2025 08:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E1F2DAFDE;
	Mon,  3 Nov 2025 08:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAPLtJJt"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C0A2DAFCB
	for <linux-efi@vger.kernel.org>; Mon,  3 Nov 2025 08:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762157978; cv=none; b=UxtCmIJwv4SzYrBldFtWMd4OOL6A6ntch5GJJCT2jxZuYaCDtgPL88pnfk1nkzULAKd2fsLoCwnYbatCpFAWp3PnbWXiBnrcfdxGebduQDuadR/arSC0JJoECaZK90YDotMleUAojtsJz83NwVLhxXuS1JPGM07lj+CH5REa1PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762157978; c=relaxed/simple;
	bh=hm6y4Bhy6ai/EAscmvamJwwl2CvRbAWBdrHlLHTEYBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIJ7p2V+4H4bZXKtYUZNWmSkn00K/kknT/HW/J+1mU4APM8yALwpqj1/t5m7rbaajjI6r6igG3r1mIU37WBVOMOFZ9h9wN/Nrl5SUQuK0rqBurvkqNPbDmKPDdSYLlUrX5FdhZ9B5sw8Xcr/oOXdusvagpSVS1smOdnigUahqXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAPLtJJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA181C116C6
	for <linux-efi@vger.kernel.org>; Mon,  3 Nov 2025 08:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762157977;
	bh=hm6y4Bhy6ai/EAscmvamJwwl2CvRbAWBdrHlLHTEYBU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HAPLtJJtfGDr+lyJTTWoCn13oYm/P5Nl/WB2TWHy6wYT9YQE+9n13Vr5Y+wiOP4OC
	 0UQgAZ4VqvsogU4z6oHeL9PVM0NfACJnKUqJ/ThBTspJ1mHjLYpDg+IiOy7Rdk+xNO
	 2Z2FR4WQIMA/4UnYbIUFmRrOTCy4x9ixKzPrekPI0AGaZ/QmH2VLNNr3CH5ggXbvR3
	 xfNd8ozCTJNUTIdlK81JDlF+fM7TVVSs84tNjIVRWEzP5XaXQsjtcChUlMjPOuwhrN
	 YR34OwsHRETlrmP+CG+gPjs9J3eSE/LX7iyp2p53dWhmXrLvpZH0XqwpP3OioU+Zkc
	 7RKlcEQ0CSPFA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-378e622e9e3so48594361fa.0
        for <linux-efi@vger.kernel.org>; Mon, 03 Nov 2025 00:19:37 -0800 (PST)
X-Gm-Message-State: AOJu0YzBXZ//7pOW6+v3zSC23DMNk3PcFtYSz3W35OaNJEuHTei3HTry
	l/3daJHdBFg5xLZuJY/toBrxpf9Hkn/RfxsBoGUAJe3fXlc1pflRUZ7geF24Vn1DcEQguYryH1T
	Qa5JgvDjJX5tVvDYPFvaQrcXLPab9JPw=
X-Google-Smtp-Source: AGHT+IGkeypsY/UdqEGhP7XlbiVMQiOiYAlR0y7VfiumjdVwneCl8iaXNCxzpbiQetoVGMKeIM5XC7xOM0spZmptbpo=
X-Received: by 2002:a2e:be13:0:b0:378:e0f3:53c1 with SMTP id
 38308e7fff4ca-37a107223d9mr50510791fa.18.1762157976317; Mon, 03 Nov 2025
 00:19:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102001411.108385-1-francescopompo2@gmail.com>
In-Reply-To: <20251102001411.108385-1-francescopompo2@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 3 Nov 2025 09:19:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEUL-Uv4tCx5NLVHDRo-BdEK1xJdee-UYs-ymE-mLxv0Q@mail.gmail.com>
X-Gm-Features: AWmQ_bkjZffiPSxqGU8AZFkycwpZNCBdCbGRQWaAyVDQQ_JPvl1H9XTwBXeyILs
Message-ID: <CAMj1kXEUL-Uv4tCx5NLVHDRo-BdEK1xJdee-UYs-ymE-mLxv0Q@mail.gmail.com>
Subject: Re: [PATCH] efistub/smbios: Add fallback for SMBIOS record lookup
To: Francesco Pompo <francescopompo2@gmail.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Francesco,

On Sun, 2 Nov 2025 at 01:14, Francesco Pompo <francescopompo2@gmail.com> wrote:
>
> Some UEFI firmware implementations do not provide the SMBIOS Protocol,
> causing efi_get_smbios_record() to fail. This prevents retrieval of
> system information such as product name, which is needed by
> apple_set_os() to enable the integrated GPU on dual-graphics Intel
> MacBooks.
>
> Add a fallback that directly parses the SMBIOS entry point table when
> the protocol is unavailable. Log when the fallback is used.
>
> Signed-off-by: Francesco Pompo <francescopompo2@gmail.com>
> ---
>  drivers/firmware/efi/libstub/efistub.h | 17 +++++
>  drivers/firmware/efi/libstub/smbios.c  | 99 +++++++++++++++++++++++++-
>  2 files changed, 113 insertions(+), 3 deletions(-)
>

On which platform does this fix an actual existing issue?

> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 685098f9626f..68582ce81370 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -1151,6 +1151,23 @@ void free_screen_info(struct screen_info *si);
>  void efi_cache_sync_image(unsigned long image_base,
>                           unsigned long alloc_size);
>
> +struct __packed smbios_entry_point {
> +       char anchor[4];
> +       u8 ep_checksum;
> +       u8 ep_length;
> +       u8 major_version;
> +       u8 minor_version;
> +       u16 max_size_entry;
> +       u8 ep_rev;
> +       u8 reserved[5];
> +       char int_anchor[5];
> +       u8 int_checksum;
> +       u16 st_length;
> +       u32 st_address;
> +       u16 number_of_entries;
> +       u8 bcd_rev;
> +};
> +
>  struct efi_smbios_record {
>         u8      type;
>         u8      length;
> diff --git a/drivers/firmware/efi/libstub/smbios.c b/drivers/firmware/efi/libstub/smbios.c
> index f31410d7e7e1..21f499035b37 100644
> --- a/drivers/firmware/efi/libstub/smbios.c
> +++ b/drivers/firmware/efi/libstub/smbios.c
> @@ -33,6 +33,93 @@ union efi_smbios_protocol {
>         } mixed_mode;
>  };
>
> +static bool verify_ep_checksum(const struct smbios_entry_point *ep)
> +{
> +       const u8 *ptr = (u8 *)ep;
> +       u8 sum = 0;
> +       int i;
> +
> +       for (i = 0; i < ep->ep_length; i++)
> +               sum += ptr[i];
> +
> +       return sum == 0;
> +}
> +
> +static bool verify_ep_int_checksum(const struct smbios_entry_point *ep)
> +{
> +       const u8 *ptr = (u8 *)&ep->int_anchor;
> +       u8 sum = 0;
> +       int i;
> +
> +       for (i = 0; i < 15; i++)
> +               sum += ptr[i];
> +
> +       return sum == 0;
> +}
> +
> +static bool verify_ep_integrity(const struct smbios_entry_point *ep)
> +{
> +       if (memcmp(ep->anchor, "_SM_", sizeof(ep->anchor)) != 0)
> +               return false;
> +
> +       if (memcmp(ep->int_anchor, "_DMI_", sizeof(ep->int_anchor)) != 0)
> +               return false;
> +
> +       if (!verify_ep_checksum(ep) || !verify_ep_int_checksum(ep))
> +               return false;
> +
> +       return true;
> +}
> +
> +static const struct efi_smbios_record *search_record(void *table, u32 length,
> +                                                    u8 type)
> +{
> +       const u8 *p, *end;
> +
> +       p = (u8 *)table;
> +       end = p + length;
> +
> +       while (p + sizeof(struct efi_smbios_record) < end) {
> +               const struct efi_smbios_record *hdr =
> +                       (struct efi_smbios_record *)p;
> +               const u8 *next;
> +
> +               if (hdr->type == type)
> +                       return hdr;
> +
> +               /* Type 127 = End-of-Table */
> +               if (hdr->type == 0x7F)
> +                       return NULL;
> +
> +               /* Jumping to the unformed section */
> +               next = p + hdr->length;
> +
> +               /* Unformed section ends with 0000h */
> +               while ((next[0] != 0 || next[1] != 0) && next + 1 < end)
> +                       next++;
> +
> +               next += 2;
> +               p = next;
> +       }
> +
> +       return NULL;
> +}
> +
> +static const struct efi_smbios_record *get_table_record(u8 type)
> +{
> +       const struct smbios_entry_point *ep;
> +
> +       ep = get_efi_config_table(SMBIOS_TABLE_GUID);
> +       if (!ep)
> +               return NULL;
> +
> +       if (!verify_ep_integrity(ep))
> +               return NULL;
> +
> +       return search_record((void *)(unsigned long)ep->st_address,
> +               ep->st_length, type);
> +}
> +
>  const struct efi_smbios_record *efi_get_smbios_record(u8 type)
>  {
>         struct efi_smbios_record *record;
> @@ -43,9 +130,15 @@ const struct efi_smbios_record *efi_get_smbios_record(u8 type)
>         status = efi_bs_call(locate_protocol, &EFI_SMBIOS_PROTOCOL_GUID, NULL,
>                              (void **)&smbios) ?:
>                  efi_call_proto(smbios, get_next, &handle, &type, &record, NULL);
> -       if (status != EFI_SUCCESS)
> -               return NULL;
> -       return record;
> +       if (status == EFI_SUCCESS)
> +               return record;
> +
> +       efi_info(
> +               "Cannot access SMBIOS protocol (status 0x%lx), parsing table directly\n",
> +               status
> +       );
> +
> +       return get_table_record(type);
>  }
>
>  const u8 *__efi_get_smbios_string(const struct efi_smbios_record *record,
> --
> 2.51.0
>

