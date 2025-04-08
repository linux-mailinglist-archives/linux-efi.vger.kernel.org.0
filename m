Return-Path: <linux-efi+bounces-3232-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4385BA7FD18
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 12:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1E4423B2C
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 10:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED3C266F17;
	Tue,  8 Apr 2025 10:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoIqO+Ic"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69394266B43
	for <linux-efi@vger.kernel.org>; Tue,  8 Apr 2025 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109273; cv=none; b=gi1rJhEDPoY2pghsBoj96pzq7LZCkWk2KqvF8HDlLWkmZocenehnK/bptJoLiq8LfqEhjq8kZ4/wip7RwJwvQ0du+jEVdM1Nv9A5wWjblvUPcMRfw+p+b30pXqyY82kLBDrZLMCgvayBUgGHupliV4M7TF8EnkgqNJGrtJoJy74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109273; c=relaxed/simple;
	bh=eHM9+gYI8bzVe2YUlsTCaKAbH5gRydceZgSInfG4ZGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HzyIbhDGS8PsJ7CUN2Zbffk5lW19872pyD0TaCEik//4gbGJQFqa2LaabOkWAO+T1BZ0LIzO2dFah4dB/nlj6laxKZrOqHJxJLO8pq4+oWEXJKpqxIhaNdeyxitypuggaGErk9d8b8ncD6+F6e7O8/UqTfL8RnPoANOI+DlyoJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KoIqO+Ic; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744109271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4xw+wBnQVfWgv0zC6Ricz7sQ1fp9U8GQwNm1YcDj298=;
	b=KoIqO+Iczffu9X7OOTBEJkkuHbTbSkfEfuaABkrgYm3rPrZPKwkfbnc6xoYXObGnWNQ8d+
	LGtw6lGqMo1NePWdHm2sTjZ6c3+ShP4lVT6/8d/iWuT8P37i23xR5elHrEdjGQCv2lvpg0
	q1TP/qCTUBgYv4f0RbxqzBuP4Ba8RqU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-Kmwb6LK0NMKLTht14xdEnQ-1; Tue, 08 Apr 2025 06:47:50 -0400
X-MC-Unique: Kmwb6LK0NMKLTht14xdEnQ-1
X-Mimecast-MFC-AGG-ID: Kmwb6LK0NMKLTht14xdEnQ_1744109269
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39979ad285bso3241013f8f.2
        for <linux-efi@vger.kernel.org>; Tue, 08 Apr 2025 03:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744109269; x=1744714069;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xw+wBnQVfWgv0zC6Ricz7sQ1fp9U8GQwNm1YcDj298=;
        b=Gq7ScY3vxC4cHEM0CNue+gdPTaVm27YuU9kHAGWfDplnWEXJGDcKzmESDiaDlBo7Dk
         0LpKLnHc0jJBu550f0S242+63SmGH6LDudwyn393QzV3eN971q6BgK0PKUpB3D5FgeJn
         Xli+h+Iw0DB+o2Nuhue6vEg0A1UuaVkBuV/toqyc9H+mxXcnDnfVtNxIfpaD0Qgl3Aeu
         ztmHNMTUT9ug3K1g9z4wXc7AoJJXB/Jmz8ztnEfJJyFaMsq/M2OqWzhodDDrav21vDTz
         wbz0BL1uMUFitoaMbZ87pumqfq43jbCSQ4Yxfm9cMIYmiJ4Qq4KJP67ovSg4oPyNtTTd
         X12w==
X-Forwarded-Encrypted: i=1; AJvYcCXKKJyQ7dFSxYnTQT8LT0iaHMx5QVjHaegQIY8CfRDoGmcVm3UsBdQySBwo7Zy13Un3DPg4G8WCZFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywacy2gSVIve8sn/WieQo8+ygqTl65ku7M+TMCjqdW6pcjrDuhQ
	C4Dq0XJOsureTytIIby0zFhPNP8ZnvQbQm1mX8ru9UzNBvQvSIu+YOWLzq4cCI5rRP0moCi3jn1
	0f3Ipogt0+MGuPP7bVVosvPw7JCpwRKXCzpuFqLT35vtjbSRAoOU7V1u+JQ==
X-Gm-Gg: ASbGncvCgYP5lmRERVDqW2o9Qvp8CcScCStotdhVhZ9fZGxBMNVrIbsvU74Oi/kubTl
	7C+aOj/Xa6IogdcaYj8a0Kfem43oSLOvZLN6S9bRdYkQ+nJGL5r2eTDwKdm4Ujay5vZVnuKjHym
	dOsOng/pzRPBRj41ApSzR8G4TH0OUr8SJnGANJbQhICy4yGbful6X/BTr4PXFNZ4PDZbMT91Vpz
	UG3r2lVGRiOKM35PLi1RXUn6DnYkpxqTiodH47dAE1vlYTLbgl1t0I4QS4rSzkItFYILvW/OQVx
	GasiyulEsOb7SYOMwrKRC4cyM09CQ8jZXiNI/TZwBSCH+Esz5krr8Fcecj4/bXr48XvAtvrSKw=
	=
X-Received: by 2002:adf:b611:0:b0:39c:1257:ccb0 with SMTP id ffacd0b85a97d-39d14765fd3mr9548182f8f.59.1744109269043;
        Tue, 08 Apr 2025 03:47:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh1uMDeBq+pU4IaUBuRFJpmb8rjcktVpXoisHx2sKdsI8ltO9xVwk8LYU0/ltb7JZRqus7Rw==
X-Received: by 2002:adf:b611:0:b0:39c:1257:ccb0 with SMTP id ffacd0b85a97d-39d14765fd3mr9548170f8f.59.1744109268665;
        Tue, 08 Apr 2025 03:47:48 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a79aasm14836365f8f.35.2025.04.08.03.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 03:47:48 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org,
 linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 1/2] efi: Export symbol efi_mem_desc_lookup
In-Reply-To: <20250408091837.407401-2-tzimmermann@suse.de>
References: <20250408091837.407401-1-tzimmermann@suse.de>
 <20250408091837.407401-2-tzimmermann@suse.de>
Date: Tue, 08 Apr 2025 12:47:47 +0200
Message-ID: <87a58r9bfw.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Building efidrm as module requires efi_mem_desc_lookup(). Export
> the symbol.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


