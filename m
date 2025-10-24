Return-Path: <linux-efi+bounces-5124-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C467C0575B
	for <lists+linux-efi@lfdr.de>; Fri, 24 Oct 2025 11:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109041AA2055
	for <lists+linux-efi@lfdr.de>; Fri, 24 Oct 2025 09:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CFC310640;
	Fri, 24 Oct 2025 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkvePpkV"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5032C30DD00
	for <linux-efi@vger.kernel.org>; Fri, 24 Oct 2025 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299805; cv=none; b=TPiRHuDIIik++QTBLxp2hutU0R9Zgq9i2kHNJG640Mr0qmYUZ2t54UZoOIv5DHuvzNDp27Cvip1bJcAVJL4g5c23PF4onADQrWvK0b/jTanjiY0HHdfiAcQv5GMTtfDnalrMCT+qEBhmBWgzNTUR7+ttU9e6uCC3mIMGTOSoi/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299805; c=relaxed/simple;
	bh=lE+aqX3/HfP4eohECIS4sCy34gjsb0rrBjjsaCwcvWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kFFL70IYoCP/3hS4Fu6sp1QvR/118EmbWGQBS7ogqxqzJcja5gYB6m1XOjU8izu0jl9+Y19ufDraoA6e+v20lB10Ms1c0h3mB22DlZOpC4/VgE6dLHi+Df9Gk1F5hK8BdqzpVFP7iYyI5wgNdCbHdjc7P+a8BQmxFl/Z+mPp5Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hkvePpkV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761299803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KFdXG8UsUCKKwuBuj5kudW0rIy6xekadEYj183tppO8=;
	b=hkvePpkVEYDm2bP6pHm8cG7Z5Y+XW8EK8VUZMm5LVEtTIsWkDbAQaO0X6J/AJzUmki6Kok
	u6gID2+cvM09E8yakBc696vaaZruWTOs49ucTeLGtLjL29t0NhTl2dQrfy+t0byJx+gPiH
	nOgI/0yjveKbbhe0B9iDrTrkZo9JkaE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-AZ89rdC7PAu5g189QR6HHA-1; Fri, 24 Oct 2025 05:56:41 -0400
X-MC-Unique: AZ89rdC7PAu5g189QR6HHA-1
X-Mimecast-MFC-AGG-ID: AZ89rdC7PAu5g189QR6HHA_1761299800
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-470fd92ad57so18966785e9.3
        for <linux-efi@vger.kernel.org>; Fri, 24 Oct 2025 02:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761299800; x=1761904600;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFdXG8UsUCKKwuBuj5kudW0rIy6xekadEYj183tppO8=;
        b=MlC+PyCGVWb7+MpJEDeAX9qEoQ4StqSw3K66USmj1CJK1APLLkL/8tdiAkVjjYgSlQ
         s1GvBw2c8t4l7Me7gT/IytOqitrMZbmKTNB5VIGk3+iD7dPLXaU8/nc6aQ8I2Lhu9cHb
         JwGkT5vw/EZbDVXdemIVj92XGP44fVUuVqFRqvejZTzYILbtVYmRDpDlJNR99pbgvB5s
         UzF1JI4IRBERvL5dLhXI36Ii0Ry38/uaUsl0po06ke5Aw2MwMET9aD+S0SWfgWa97rG6
         ZEOYVYpM15lb1ILLaunsFGNoVlxC1zRLHaiYedbSgbjzoY0NAvVHUdkc2JFXnQXMMk+3
         gf0A==
X-Gm-Message-State: AOJu0YxsTMlw8M/xRkfLrBt0S1NAb7wkAZhf/Vk7RUyfXfOeIk6oagak
	WaOnMOCAE9a6kOOfmpigXEB3y8mLK467LvIV7Z3ktyyRLAGpPeJvJHThNKR6KhNRk6eu5Gz/IUt
	AGrK/+pogSkZJ9jiSNBhaep6BRaRl6wSQz6aiAdRPJxUhBzXUQ+CMFTvIFIDGjQ==
X-Gm-Gg: ASbGnctO8Uall5FGOadG4M+2j5fktANkUm6MjdKTymCFsugQdb1x/rKqe8mzwD1EHBe
	l/zcYPTphIESwQfJY/l+14iNFRgpxdb1XOec83RNoG5N/2jVV6KHnULhWe+l2VTGUmDEJnS0lfu
	ieTh074Q1AnPZg4Mf2eAGVPvxIpvqcpXCzelrwdDRPoIoMDZj/FLk/eGMbvgNpUwHxCIVzZ3ATW
	lT9oa3EgCltXg1lF2iitrks2UTaWLALqewR0AYh7wtRP0R9Fzmg8FiPU+hUOmhe7du6Zc8Sv9u2
	rJXk6eGF0K3E1XiQP3f7SzeEcsFBfEouh3+X6ThnI6lPk3sm8uepVri1c/GNmvuEgb7xg//CuCY
	yY2OW+HvsQdh+thduN8GbbLcI95u9ReSGtLsRuJkLq7b+bgIcQxNHMBXL/g==
X-Received: by 2002:a05:600d:4382:b0:475:d891:ec8c with SMTP id 5b1f17b1804b1-475d891ed03mr3176305e9.3.1761299800033;
        Fri, 24 Oct 2025 02:56:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYFxEJ+9vf53evEcAEZdGSa/MAWvLHBF+QBptEwj6rOjmFDqkrATeIFVyZrNhoUbZizrVxrQ==
X-Received: by 2002:a05:600d:4382:b0:475:d891:ec8c with SMTP id 5b1f17b1804b1-475d891ed03mr3176075e9.3.1761299799657;
        Fri, 24 Oct 2025 02:56:39 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475cad4c81dsm83937215e9.0.2025.10.24.02.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:56:39 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org, jonathan@marek.ca
Cc: linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 4/5] efi/libstub: gop: Add support for reading EDID
In-Reply-To: <20251015160816.525825-5-tzimmermann@suse.de>
References: <20251015160816.525825-1-tzimmermann@suse.de>
 <20251015160816.525825-5-tzimmermann@suse.de>
Date: Fri, 24 Oct 2025 11:56:38 +0200
Message-ID: <87qzus8vxl.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Add support for EFI_EDID_DISCOVERED_PROTOCOL and EFI_EDID_ACTIVE_PROTOCOL
> as defined in UEFI 2.8, sec 12.9. Define GUIDs and data structures in the
> rsp header files.
>
> In the GOP setup function, read the EDID of the primary GOP device. First
> try EFI_EDID_ACTIVE_PROTOCOL, which supports user-specified EDID data. Or
> else try EFI_EDID_DISCOVERED_PROTOCOL, which returns the display device's
> native EDID. If no EDID could be retrieved, clear the storage.
>
> Rename efi_setup_gop() to efi_setup_graphics() to reflect the changes
> Let callers pass an optional instance of struct edid_data, if they are
> interested.
>
> While screen_info and edid_info come from the same device handle, they
> should be considered indendent data. The former refers to the graphics

independent

> mode, the latter refers to the display device. GOP devices might not
> provide both.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

[...]

> +static void setup_edid_info(struct edid_info *edid, u32 gop_size_of_edid, u8 *gop_edid)
> +{
> +	if (!gop_edid || gop_size_of_edid < 128)

Can you define a constant for 128 instead of having a magic number ?

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


