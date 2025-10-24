Return-Path: <linux-efi+bounces-5125-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C354DC05774
	for <lists+linux-efi@lfdr.de>; Fri, 24 Oct 2025 12:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85733503130
	for <lists+linux-efi@lfdr.de>; Fri, 24 Oct 2025 09:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7310F30DD28;
	Fri, 24 Oct 2025 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9958Z30"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9990E30DD34
	for <linux-efi@vger.kernel.org>; Fri, 24 Oct 2025 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299841; cv=none; b=H0eCPYa96XhQmdaTjdoHZuxMUxGlK5fK45OdGsmos3S9QwqiMr55l4qPZH8vCbePqmWzTHgv9rd8hrCGoXFS+2Ixtdub6E2vB//9X0yIHzJh8kZoreSgHkNQBIJIONvn2toyeSoacEVd8BUo+RivYiQK9+UQkC/4Oqaw+/J3eGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299841; c=relaxed/simple;
	bh=nIEK9cEhnaH1yJ2ZUGlKpHTQhWUHwyWzPZXXs9pPUfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iEKimbJMFjSCMOt3/1Zy4G89ng5pnkoDKPY01jrHpeucdjxMf5gIphcCYzVcl0wyQ3yIWbqfLpwOBSEVHtJBKJtbmnuyQxS+P1+gSmDnepcrusy+p3aR6xjENbjff5G5H3VF0fUdjBv1IEiS0Xf9dmuzYT1EiHpVB6yIOYMCV5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F9958Z30; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761299838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EECPZ9d8E6GPLO4i/dKA5m4dqP651VCNME9poiUNpOs=;
	b=F9958Z30q0/3e6wS87x5IcwJJKgbL122UPkU3uJNojD4eNfup4FrkAIWwdadKwkOBl+1Wu
	zm5BjA8zXSv+mhTvH9I8c3s3XmXj7VVOUcJEJWqsn7LhGHllX6A8TmGmZVOiQbu/jr6+I6
	12jXO5EwwU3oQxvgHOOVeJwUF1pmAw8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-A9y_sU8yOh-sDXWYJenp_A-1; Fri, 24 Oct 2025 05:57:17 -0400
X-MC-Unique: A9y_sU8yOh-sDXWYJenp_A-1
X-Mimecast-MFC-AGG-ID: A9y_sU8yOh-sDXWYJenp_A_1761299836
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-471193dacffso9510555e9.2
        for <linux-efi@vger.kernel.org>; Fri, 24 Oct 2025 02:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761299836; x=1761904636;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EECPZ9d8E6GPLO4i/dKA5m4dqP651VCNME9poiUNpOs=;
        b=HX4GpfAlv5Nz6j42Teg+OPjf6JDFNw81wxy0+MVsMN+dvbMTj1GC8igErsDTi8FRk2
         A+hYsy5squJdmpwE1Lm7IoAoU34IDkhL9AnL5esUGnb0LDbUpCirVbZnsMZPqN/EBbue
         SZZxHfrQ4z0ZBJ7QsUnPvsgekyFj1LFIzHIbzQuvUdVS757jw1+mWmaa+EishMcFyqup
         PprPsQ0v9jhx0jLq3IjzQoghAMur3OCqx6jODDiSIIx0BZIVuqHiSLLQzXYZgJtFCtw5
         xca6LEF81OmJH4fqdcuoarbxAN9Dm79MxcjQXSrzvip+3T0mvoNl9BGqgjz0m+qwPA2F
         hBOg==
X-Gm-Message-State: AOJu0Yy7b7UA4+9HdiDnWCJk1ttZbEYvC4pTd41vriT5xydYrhxuTmT3
	diVKK8FUNYflyzedlFkPup0pTAWBQJjorpFRAn2TAhvZXYcFMBCdHnrmtUxO9iIxRcfR4fKY1Kt
	Y4Vq6BpPPBegAK5iqXwtY3w9zZG+b3+OSdpTYaoCWYGdeqqWo+vbQfvKtyeSaMA==
X-Gm-Gg: ASbGncvecSp+MiRyjyksa7ymkQEgb54AbWKfMsB+g9mtY5ncozm4t67T5mD+Vqc7fwz
	78KUMYX7kt+CyyWrnITOBRlQg1KLIxfn3SEg3SZQOxdqeuEZvCZauyqjJ6/uHDGvd1z6yV4QDvy
	SV9bQ9LUBT7v5cup4dlw+QVhzXpGDmE9++w+O5AgW8BXhxVrVvomoQsyT0L/1OEM2UOlTUv4X0x
	c+23AYNdS0sofs1ZBdWCvu1Sqm7OSSUQ3b8r4mT1P688SLRChjI7fW4zlP6o01i4O7dykenBn6X
	JnH3qipIGqOrwN3RVLiwAtz5V0oXL4vir+290Krg9nqTHQVLhSXYZVjHxvXJDi6T0Ui5GzE/6NU
	9Etim/N2p0EJzXUcR8fyjl6wFXhJv3Bu9CnDkauosUImn2f2S5oXebX453g==
X-Received: by 2002:a05:600c:c16e:b0:46f:b43a:aef2 with SMTP id 5b1f17b1804b1-475d30d20fbmr14523845e9.38.1761299835788;
        Fri, 24 Oct 2025 02:57:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi4kHieaFnLco9wucyoKPkPcEj2osPLAl9lyR18xfQ/pKl2+mHzfqAxTuZr5DT8hf24aXQRA==
X-Received: by 2002:a05:600c:c16e:b0:46f:b43a:aef2 with SMTP id 5b1f17b1804b1-475d30d20fbmr14523665e9.38.1761299835440;
        Fri, 24 Oct 2025 02:57:15 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496afd459sm84966385e9.1.2025.10.24.02.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:57:14 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org, jonathan@marek.ca
Cc: linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 5/5] efi/libstub: x86: Store EDID in boot_params
In-Reply-To: <20251015160816.525825-6-tzimmermann@suse.de>
References: <20251015160816.525825-1-tzimmermann@suse.de>
 <20251015160816.525825-6-tzimmermann@suse.de>
Date: Fri, 24 Oct 2025 11:57:13 +0200
Message-ID: <87o6pw8vwm.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Retrieve the GOP device's EDID information in the kernel's boot
> parameters. Makes the data avaialble to kernel graphics code and
> drives, such as efidrm.
>
> With efidrm, the EDID is now also available to user-space compositors
> via standard DRM interfaces.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


