Return-Path: <linux-efi+bounces-5924-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BBDCDE930
	for <lists+linux-efi@lfdr.de>; Fri, 26 Dec 2025 11:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98D163007626
	for <lists+linux-efi@lfdr.de>; Fri, 26 Dec 2025 10:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FB82882BE;
	Fri, 26 Dec 2025 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2BH8b6+"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF450381AF
	for <linux-efi@vger.kernel.org>; Fri, 26 Dec 2025 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766743759; cv=none; b=hOP3eeeuXZn6f1xFY3kkgBYkSX5nmRFB/oaOES2DAV0FienbuPl/sTW3LO5iREhpFCqqWxrnYoBqY3wj3CjurZ5aIgN6pKd36fRWBlxUpdpMU05gX5QscuQjZQBhyFcHPevY+lzJkvBGUCzKj9CU6hnjoLtzFACbr+9zDsZ7IIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766743759; c=relaxed/simple;
	bh=xW4GlbCwbkS8hsfoIhqOHDZOpDoQ0ajJszh/A+a5+R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLmjQfuO2828NgC6Pc2RmWnPz2G49j9UNvQpmVvmgVbbTz/KBi8kQk3K5msELqtNKF2K5B3ENlwrdsSDdhYhDlqxKjEsO1Un6P3jPd021QMzHOURTiSOJmWFGPvtAyQZ3naQTQirT3XuQDufY9IAwf/0qYv0Z1sml0Am8zWNWdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2BH8b6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CE1C113D0
	for <linux-efi@vger.kernel.org>; Fri, 26 Dec 2025 10:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766743759;
	bh=xW4GlbCwbkS8hsfoIhqOHDZOpDoQ0ajJszh/A+a5+R8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P2BH8b6+bG/+8Yct4qG2/73khMGvX7l1MqYgn8AN3HOZL5lp8oPi3Qo3V+wJQK5DA
	 eV1TqZql1zPt4GEID7+P6+IiC5Fiuk9XdhO5JGQPX5vqwNzt6luB3u7s6rAal+6ve8
	 Fn08nFqFVYZD4MjL37njRXUCihFk9Pv1n/LAQv3XjxDkFbJPcvidw3RcHInhZSPYJT
	 jbSoouWEVip3lnfQML1y6qylmwg+k4ENYZnqP/rBg8qsZ8zWmCQoIIcpbbumfUNTAX
	 CdP6n9Ex+/mwKjZi3DeX0MvIscruPX0lEHTLydKpCvFb7d1wQD0QL9EiRJoqCxF86t
	 nBq0xYHwe9iZQ==
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34c363eb612so7071413a91.0
        for <linux-efi@vger.kernel.org>; Fri, 26 Dec 2025 02:09:19 -0800 (PST)
X-Gm-Message-State: AOJu0YzMUtk6dHlsfND1QiXwxPYdYppGArhc62YAgYvY0neggJykglm5
	grz+2ZI4EIOYSkW4KUsf0LvDaOZ47JvPU7YqnddtbwvDmAjJ8+FyZuREA/GydjVhXFseyJES4dO
	Zi9fm3saZPhZIFa7wIwp6SGqEKD+/aM0=
X-Google-Smtp-Source: AGHT+IGgxmYQb6CeUeRCZqsXN5ce8exq3CQevST0iJ35oaFDkzozo18RPCW9NTczgjwprNhdGDkoIfRrJQ5Yze+Ifmo=
X-Received: by 2002:a17:90b:1c12:b0:340:2a3a:71b7 with SMTP id
 98e67ed59e1d1-34e9214bebcmr23864245a91.12.1766743758728; Fri, 26 Dec 2025
 02:09:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223101046.16334-1-johannes.goede@oss.qualcomm.com>
In-Reply-To: <20251223101046.16334-1-johannes.goede@oss.qualcomm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 26 Dec 2025 11:09:07 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEuzcyCFq45gMd_wOEONihVr0Fq4u8Zk0fJJKQ0oZi=Gw@mail.gmail.com>
X-Gm-Features: AQt7F2q_ZScGKHnh4ts95jWNQPDh66rPO-68FNag--KXLYrYp6UrheZfXg1J6Dw
Message-ID: <CAMj1kXEuzcyCFq45gMd_wOEONihVr0Fq4u8Zk0fJJKQ0oZi=Gw@mail.gmail.com>
Subject: Re: [PATCH 6.19 regression fix] efi/libstub: gop: Fix EDID support in mixed-mode
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: linux-efi@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, 
	Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Dec 2025 at 11:10, Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:
>
> The efi_edid_discovered_protocol and efi_edid_active_protocol have mixed
> mode fields. So all their attributes should be accessed through
> the efi_table_attr() helper.
>
> Doing so fixes the upper 32 bits of the 64 bit gop_edid pointer getting
> set to random values (followed by a crash at boot) when booting a x86_64
> kernel on a machine with 32 bit UEFI like the Asus T100TA.
>
> Fixes: 17029cdd8f9d ("efi/libstub: gop: Add support for reading EDID")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> ---
>  drivers/firmware/efi/libstub/gop.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>

Thanks for the report - queued up as a fix.


> diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
> index 72d74436a7a4..80dc8cfeb33e 100644
> --- a/drivers/firmware/efi/libstub/gop.c
> +++ b/drivers/firmware/efi/libstub/gop.c
> @@ -513,15 +513,15 @@ efi_status_t efi_setup_graphics(struct screen_info *si, struct edid_info *edid)
>                 status = efi_bs_call(handle_protocol, handle, &EFI_EDID_ACTIVE_PROTOCOL_GUID,
>                                      (void **)&active_edid);
>                 if (status == EFI_SUCCESS) {
> -                       gop_size_of_edid = active_edid->size_of_edid;
> -                       gop_edid = active_edid->edid;
> +                       gop_size_of_edid = efi_table_attr(active_edid, size_of_edid);
> +                       gop_edid = efi_table_attr(active_edid, edid);
>                 } else {
>                         status = efi_bs_call(handle_protocol, handle,
>                                              &EFI_EDID_DISCOVERED_PROTOCOL_GUID,
>                                              (void **)&discovered_edid);
>                         if (status == EFI_SUCCESS) {
> -                               gop_size_of_edid = discovered_edid->size_of_edid;
> -                               gop_edid = discovered_edid->edid;
> +                               gop_size_of_edid = efi_table_attr(discovered_edid, size_of_edid);
> +                               gop_edid = efi_table_attr(discovered_edid, edid);
>                         }
>                 }
>
> --
> 2.52.0
>

