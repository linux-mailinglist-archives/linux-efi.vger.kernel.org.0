Return-Path: <linux-efi+bounces-2531-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7ABA0552C
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 09:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88595162B04
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 08:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C84D1ACEBA;
	Wed,  8 Jan 2025 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WeToHCcz"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4BF13B288
	for <linux-efi@vger.kernel.org>; Wed,  8 Jan 2025 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736324558; cv=none; b=ljTSdHfhTPtnUmkuVo5DOqs8rAIPxEgnpDEBf+86Oh3uTCBaKw0fyalP7FMnrfkH8X6gfm6hxZ8e8DQLvG1F7JEWZy6ZdX/HFO2t9/PMm0rlUqEBCiHSm1FX1HD4KRvRmlQbbUx+d62YbPXSP2gdUrw/MpMvEHYpSNqzciW7Aiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736324558; c=relaxed/simple;
	bh=EYI/maJ+3O4ZQqWB7dnb9bL9p2Cv51yYY68SguEA1ms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cC8z0znvwwZpN0k9eUt+ukCUOXmtZ/paNonDn8lzzoqb/tTkzKIyhcb74jbHS2t4k4mdwRqNXtjWUwHLGsFDj3et7FexsVP++R3HoyX8VKI/FZomJlnNi0knf7drgOPBZkdQqjg7R3C5iOsp09ztuasSa11RCZ1woluIZLSsywg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WeToHCcz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736324555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7yxk95csKi3GHDYbhdAxJnZiLS3KhEFUJYd2VqIlbrc=;
	b=WeToHCczYWAJPih1H0RvYMW9AZMrJfarVuyhnoabxn56VxEOqIuKLrVCrtySajR2+cPfOP
	f4pG5R1pO+twpcGTc86QuCnhWcuaPx5HZxBRaO7V2RH+mrG9FEekXYGDVBVTQcy+PhN3XL
	gnsWDUORzbh6TgrxLqd5hp6FAl0IMAc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-Cs20qpztP6-BY-P3Ygr5kg-1; Wed, 08 Jan 2025 03:22:33 -0500
X-MC-Unique: Cs20qpztP6-BY-P3Ygr5kg-1
X-Mimecast-MFC-AGG-ID: Cs20qpztP6-BY-P3Ygr5kg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-436225d4389so2294635e9.1
        for <linux-efi@vger.kernel.org>; Wed, 08 Jan 2025 00:22:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736324552; x=1736929352;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yxk95csKi3GHDYbhdAxJnZiLS3KhEFUJYd2VqIlbrc=;
        b=X+0nhM+rAreQyKwMTAdclJv6C/4l9q2smCdqwp7ScC1db0Aazqa3VAJo0ymk/yZXkh
         RSlqKdkAMTPYOJQj4sFM0t/Y9FyLXtp/aMyQ5/0TxOIgBvhHAzx286yFEb391kPeiKUZ
         Okja07nWlgYHsxvO+MRJf8NdLghI6LSH63Ym0j2q9S+/Ba+Aep4C5G2gotcVOrRp92V1
         1e4bgtACXOAovD82x/DD5gRGzpz3OjNX6OA0b46Rfloo8HkfP92OpqLyjcPUikck6wn8
         hIubPd3qus93oN+g9zCfy7WHjZuYlqsupa9ZY5RK6nBU6ySyoxp/JvAb1JxjBr24kyDl
         VtlA==
X-Forwarded-Encrypted: i=1; AJvYcCUhXiHu16DjZcQo8202HpsaqJAgFNHNmWgpeIyD5EGcaF6e/KbuTQV6v7KcZD2BbakpmGpovMyNpc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuD0AL18NmeAvutRTpUWMZ6jll1cJ32QkTG4EUrxOAnKxurSjs
	4i/jNPnfUVygG/i7IKIkop+Sw9+Tq3sEqZtd8siszR8AnlOKSGQuoB0KpIoB0YvgzmV1/COVrF0
	3jZTLKEJpVB4CE1bMl72ZgVUTMpfC/ugTqu19jQhrvACKgZp9iGlA8c9jNg==
X-Gm-Gg: ASbGnctzQvPIhGXVinb4AXTbl/qokV0os7ALlXuSlLDIBuurwGg2kW+slTikgVQBCQf
	vYCnQW4xYCtNyXh+iO5I8Rp8+Tn5dAydtFf279y0xBdyVKKH5P+E9/zG0AXs48jvvsUiO3xy5vm
	UCFduNjN+tvt1vNwty+sOfR3VIiyuR5HhtdrYpu8tfVuYtuk4WWah9kk+f4fAo3MDEpKrCF3Xb+
	rsZsV5w1gUF63y6oUQDED7Lf6DVkL+6z06ebIyY9q+NAmhsNSawZDY6PAi9i+Mhc6YJW/tnBxcf
	3rjy+kJFJ8aaRDbQ+VFKdLN/Tt5+Z5VuzDIh4FA=
X-Received: by 2002:a05:600c:1caa:b0:434:f1bd:1e40 with SMTP id 5b1f17b1804b1-436e1dd3e30mr15578045e9.6.1736324552428;
        Wed, 08 Jan 2025 00:22:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH20Ygyhkb90BgF9irfpy0bwgtbzLNJyWLCMxf0zeohTP1yADRiBhQRdLSC2kN/1ghiJa5czQ==
X-Received: by 2002:a05:600c:1caa:b0:434:f1bd:1e40 with SMTP id 5b1f17b1804b1-436e1dd3e30mr15577815e9.6.1736324552055;
        Wed, 08 Jan 2025 00:22:32 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddd013sm12507845e9.24.2025.01.08.00.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 00:22:31 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>,
 David Rheinsberg <david@readahead.eu>, Hans de Goede
 <hdegoede@redhat.com>, Peter Jones <pjones@redhat.com>, Simona Vetter
 <simona@ffwll.ch>, linux-fbdev@vger.kernel.org, Ard Biesheuvel
 <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: Re: [PATCH] efi: sysfb_efi: fix W=1 warnings when EFI is not set
In-Reply-To: <20250107235312.236247-1-rdunlap@infradead.org>
References: <20250107235312.236247-1-rdunlap@infradead.org>
Date: Wed, 08 Jan 2025 09:22:30 +0100
Message-ID: <87zfk1iuk9.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Randy Dunlap <rdunlap@infradead.org> writes:

Hello Randy,

> A build with W=3D1 fails because there are code and data that are not
> needed or used when CONFIG_EFI is not set. Move the "#ifdef CONFIG_EFI"
> block to earlier in the source file so that the unused code/data are
> not built.
>
> drivers/firmware/efi/sysfb_efi.c:345:39: warning: =E2=80=98efifb_fwnode_o=
ps=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>   345 | static const struct fwnode_operations efifb_fwnode_ops =3D {
>       |                                       ^~~~~~~~~~~~~~~~
> drivers/firmware/efi/sysfb_efi.c:238:35: warning: =E2=80=98efifb_dmi_swap=
_width_height=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>   238 | static const struct dmi_system_id efifb_dmi_swap_width_height[] _=
_initconst =3D {
>       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/firmware/efi/sysfb_efi.c:188:35: warning: =E2=80=98efifb_dmi_syst=
em_table=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>   188 | static const struct dmi_system_id efifb_dmi_system_table[] __init=
const =3D {
>       |                                   ^~~~~~~~~~~~~~~~~~~~~~
>
> Fixes: 15d27b15de96 ("efi: sysfb_efi: fix build when EFI is not set")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501071933.20nlmJJt-lkp@i=
ntel.com/
> Cc: David Rheinsberg <david@readahead.eu>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Peter Jones <pjones@redhat.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org
> ---
>  drivers/firmware/efi/sysfb_efi.c |    2 +-

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


