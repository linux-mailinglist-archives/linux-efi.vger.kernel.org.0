Return-Path: <linux-efi+bounces-5123-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD229C05708
	for <lists+linux-efi@lfdr.de>; Fri, 24 Oct 2025 11:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96B3E4FD8BA
	for <lists+linux-efi@lfdr.de>; Fri, 24 Oct 2025 09:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CBD8F40;
	Fri, 24 Oct 2025 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgxsyiPG"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD6930C62D
	for <linux-efi@vger.kernel.org>; Fri, 24 Oct 2025 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299621; cv=none; b=A4eGhGOk1db22jjm94FUoPLDgMsmf1RevdQQqwYQQ2wqXn9RUjvOOYt8Bi1OVL05xmVr/eYJwFVV3pOIMLPjnUq5mhgHX5inr8FyiRLr5Nx0ZY1Ml4GKHFrKEsQpzx3N8yvs/UBuwgb2dILxrqMdHiCRVLke45V998RfSoE6NPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299621; c=relaxed/simple;
	bh=2svO9jFdsPmFpDev1N+tmZRzalxhNtErGE/4c5iY+j4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JsFc9H3WEHdXG3os5meF5ilKrwvfrA3AfTPzBEnW0UOOybtahxUbUq8ORhLgDHxQggn8LUSZTum7RYUZ6jQAbEB270bG/0rbAud8487/jRrGTPxkdBFOOTNxgaWXc3P5u21nsFVdAYtr2ddY0OitB1UFsKE7yLrE0D+d7HROLdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QgxsyiPG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761299618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MfM4FRUtlcJmtbsNTeaFiHY2x28gTtqtBZeKbwh4hhU=;
	b=QgxsyiPGaDp7gp+FE+TBK3KlWcoF7ZUK6C8NA0hu2iz7UNYTGyi0QXmr0mR+V8tKQoAix+
	f2evmmBDbjv0H5gu/9FxAyA6QfXFqZljl7wNqqn2Z4rzWUeH76YV5p+PIYzQOFWvuus6Jm
	jYbWLXJUYcfD1iT5YfvqNJo2RnAsEMA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-cBa7B_YCPG-H8iw9hdi8ig-1; Fri, 24 Oct 2025 05:53:37 -0400
X-MC-Unique: cBa7B_YCPG-H8iw9hdi8ig-1
X-Mimecast-MFC-AGG-ID: cBa7B_YCPG-H8iw9hdi8ig_1761299616
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47496b3c1dcso13114975e9.3
        for <linux-efi@vger.kernel.org>; Fri, 24 Oct 2025 02:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761299616; x=1761904416;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfM4FRUtlcJmtbsNTeaFiHY2x28gTtqtBZeKbwh4hhU=;
        b=E6gdcncn1H7g2c6c0fwxXCblyIUWLChhNmcNZUxzOSfTbHnQseIC3onJ2f63vfi0xb
         dUEMVR+u0ltHdVq2H6SJ3kvMNa+vae9fpH0YNrpaXX1S+ZtoQIGGCbwDc8rkAUyTse3e
         uevzybPrSZgfXRklU/vqUEkFkD7VZ69tpgvB5eHsel6DmmZTuv+ck+Zgk9xs5tiQtBbW
         rJ1bfhzl/cWuQmLnKH3EW8gSuS+RVMGx7tj0mAnb8tqWQ7lWWfdTnvMFyGC0N/AbdHM+
         MrnBJcApIpiPS2VvYlrzptEiVhGJNlzFm+BSrrcvwF+1oFqNd9Z77RNcAvJOtsTK84Xj
         /Krg==
X-Gm-Message-State: AOJu0YyHbm1FJQK/qqjnZ1jmCywf7z9I8gu1Bnx15oxjlTXFZYXbcLZr
	AwokmXs8YMUcooQ3eANc1dybHYnJUqJ6pH5UBD87c44RgjK9Q2HTt+JXS+Lm6rPbGEsbN6mspa8
	+EYa9c0/ORqEBb9XIHgDT+MGAMvxBvoB1eCBZjxP3D7C+twcOMgwC1QdrxkUEBg==
X-Gm-Gg: ASbGncv/MDT7dloFnjfg/0HtRXFgdXhtVX3edjtbE6A6iYlWEEUq73pzwLsWHYCFiUj
	iNjT4AJIvaKQSbz0iu7CAoEtLCcOvyi+ymxbXVXVBBIK76SUV0DNkVAyhRTYwI3ONmwfRaCGPf7
	JY/WTCwrpuWxEbFCjTWGIUaBQCibxk+UXol6efH/8OzG/5Hu2Z8y4rz+ZTqbipYPI3bg/NATYjW
	PTZ734yQ2gpNri4iqq7CJshFtVfbhWn0nGoRHri+uA7NmEziB5ytyzIvLfj3K430prwzS3k+6Co
	T1/81EoZKKPBX0TwoOYRY06eVE0y1OatNDf3nvffCjcxnoal1DCRzmuWC19SjwnV0mAbxN6JB/M
	EogjCGlvx6Hklfm9ccSuTD+5PcJXlC5uCaidqnB0Uxq7ccqQhFNFQPm3h3g==
X-Received: by 2002:a05:600c:1ca0:b0:471:168f:717a with SMTP id 5b1f17b1804b1-475d2e84559mr14828435e9.16.1761299615858;
        Fri, 24 Oct 2025 02:53:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrWpIk5fPtJQaBUOqbuLg6LOKynRISy3ybOJ2Vo42hxf7aA0YpLztkvhOtyOyFfq+o4GK3XQ==
X-Received: by 2002:a05:600c:1ca0:b0:471:168f:717a with SMTP id 5b1f17b1804b1-475d2e84559mr14828155e9.16.1761299615418;
        Fri, 24 Oct 2025 02:53:35 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494b22536sm80851935e9.5.2025.10.24.02.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:53:34 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org, jonathan@marek.ca
Cc: linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 3/5] efi/libstub: gop: Initialize screen_info in helper
 function
In-Reply-To: <20251015160816.525825-4-tzimmermann@suse.de>
References: <20251015160816.525825-1-tzimmermann@suse.de>
 <20251015160816.525825-4-tzimmermann@suse.de>
Date: Fri, 24 Oct 2025 11:53:33 +0200
Message-ID: <87tszo8w2q.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Move initialization of screen_info into a single helper function.
> Frees up space in the main setup helper for adding EDID support.
> No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/firmware/efi/libstub/gop.c | 76 +++++++++++++-----------------
>  1 file changed, 33 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
> index fd32be8dd146..02459ef0f18c 100644
> --- a/drivers/firmware/efi/libstub/gop.c
> +++ b/drivers/firmware/efi/libstub/gop.c
> @@ -367,24 +367,31 @@ static void find_bits(u32 mask, u8 *pos, u8 *size)
>  	*size = __fls(mask) - *pos + 1;
>  }
>  
> -static void
> -setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
> -		 efi_pixel_bitmask_t pixel_info, int pixel_format)
> +static void setup_screen_info(struct screen_info *si, const efi_graphics_output_protocol_t *gop)
>  {
> -	if (pixel_format == PIXEL_BIT_MASK) {
> -		find_bits(pixel_info.red_mask,
> -			  &si->red_pos, &si->red_size);
> -		find_bits(pixel_info.green_mask,
> -			  &si->green_pos, &si->green_size);
> -		find_bits(pixel_info.blue_mask,
> -			  &si->blue_pos, &si->blue_size);
> -		find_bits(pixel_info.reserved_mask,
> -			  &si->rsvd_pos, &si->rsvd_size);
> -		si->lfb_depth = si->red_size + si->green_size +
> -			si->blue_size + si->rsvd_size;
> -		si->lfb_linelength = (pixels_per_scan_line * si->lfb_depth) / 8;
> +	const efi_graphics_output_protocol_mode_t *mode = efi_table_attr(gop, mode);
> +	const efi_graphics_output_mode_info_t *info = efi_table_attr(mode, info);
> +
> +	si->orig_video_isVGA = VIDEO_TYPE_EFI;
> +

Not related with your patch but I dislike so much the name of this field,
since it started as a "is VGA?" bool and ended being an enum afterwards.

But I beleve we discussed this already and decided that it would be too
much churn to change it at this point.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


