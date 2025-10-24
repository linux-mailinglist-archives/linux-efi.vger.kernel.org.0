Return-Path: <linux-efi+bounces-5120-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C21EC054BB
	for <lists+linux-efi@lfdr.de>; Fri, 24 Oct 2025 11:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8D804E4D17
	for <lists+linux-efi@lfdr.de>; Fri, 24 Oct 2025 09:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB3F3081A2;
	Fri, 24 Oct 2025 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYobzKrN"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B4E26B0BE
	for <linux-efi@vger.kernel.org>; Fri, 24 Oct 2025 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297584; cv=none; b=ckwFAgiwxC2E3ELszI1WLR0Hh+3Ei57ZESQ0znXw/1gjA04dsHlm28n7JfjeyUfBcVqEbnO+EFv5FIfFZ2oIFg7N+Xsu+KauYwu1/VjvdJVCz7t+e5wB41UH7Gj8HlpAgnrK9EqX21L7WsCbkcAFECAaEHpCz+E6V/QZQrMnHIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297584; c=relaxed/simple;
	bh=j8G9QdbIqwBg2IhRIRuqyIIJgusHkL5GWb5WXWEG8ZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=engTOX0/tdqgmz1aiPBY0nSqeaSZSMhKnF3arLcwTHifHa0i2Q1i66vPpvTlbtpn/NRh146CqCtudFhA5SL1aFkfhuRKOgIWr/xawQF8kcoAspd+RX3OZwgyVYY/ova07Rf0yVz4bNKgcqATxOcuUoChqR0ScFDuaLyV7a02Ka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AYobzKrN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761297581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gjlhKf1lSLezGbueO5hgy+8/2iDTdqmHQ6e26A+MZvI=;
	b=AYobzKrN9yVSMU1MoUKeMqkWGLsiaiZF0hYaVjycq8fGQORSDAEGGMio2OXyVlTj2mZeol
	3ewu/TuJb9QFZ3TeHQD2obrt7Fo4vOMXWvmJQHrcFOojusC4oDGdOdF2AOJAL1/Hbsb+hX
	xBS5YZJaykdH39RRwgDdA4H3P1MB1OA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537--vjmoTGNOmi-zNQiuU57Gw-1; Fri, 24 Oct 2025 05:19:39 -0400
X-MC-Unique: -vjmoTGNOmi-zNQiuU57Gw-1
X-Mimecast-MFC-AGG-ID: -vjmoTGNOmi-zNQiuU57Gw_1761297578
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4710d174c31so19475515e9.0
        for <linux-efi@vger.kernel.org>; Fri, 24 Oct 2025 02:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761297578; x=1761902378;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjlhKf1lSLezGbueO5hgy+8/2iDTdqmHQ6e26A+MZvI=;
        b=DZiiFb538G1WYLY5rlkkB1n2zs8xXUzEvhbSCsE5VG84rUoEnSqpzy6dFXOQTRZcwt
         WOcGMgjZCQw1Qz+lnL7TA6Lcq992XZZ4tFdfOa84WddVmC1eOLalY5xIod/uVmCIl2N6
         1niWcuznzAo9NKclAivaM1vmdMWE/a+1vJMSbQNCTbkVoE5hjmvVhvYJU5R7kJULsc5Z
         bT0QqSZubROl0CEa9Knx4z0PUL5YjQOpLBomHFSUgTagYJ3nOPD6zFZGATyW0b8BIoPW
         p848obkTIR0LyxP/BAYjxV3QDh8uU/XTpgATRvCNW1OoBuSLQF83+nBl5dXtPw1Utxh0
         vJow==
X-Gm-Message-State: AOJu0YzFt1TAk7elKaul1xKcSjugVyGDlAQR1TeBwko8yuihB5w7Tzbw
	9DH8Z+NN2CJvybKpP9jWrEiVErP7aKkEJ3nQjYOMZDWxTDVEsmjs26MBGW6U/CNP//KRmn7lJbY
	poY72GdyS2X8TJ4YBjLObBtGWMrrWuVjwUxK4bmWm5Xk39B9aZ5Bv+P9cd8A+Fw==
X-Gm-Gg: ASbGncu852HOD1WSP6jY9JjdwFKWwBONZPNTlwSV/GuLL2054UPSQcvUK8VeuJ+z530
	u2LcHJPQJTX5GSaStS+0Wefq82CyedoxHx8l41TF++AMOmGXUecPxALSLZ2Xiq2zWZv4SDaIATu
	vbG0e3U6tfdkmOJFNPPVyNDYhfI5hiFZfYDR2zLvpZrzfBefbOQ1Ifo8VH123DlVxQh8BLEQVm3
	ueOLCs8zJD0DV0Tbw5M51pZ9agJslnuSkFO/I6XbJqe83d8XTgQjQzjOWGXTJhvSDngeeJqYjnX
	k/ilLvQpXSAV0WYDrm6mooaroc1PwJCdd6YFWI3WiLOKxmX6U+/As08MLuM2h79tZ9wvNfXTYvv
	bXEDYlAXyrAjy17KQhJujs3GCCFDZtSTitV+AvKC+ptkfNZ9Pi3DkIWfTmw==
X-Received: by 2002:a05:600c:820b:b0:471:1717:40a with SMTP id 5b1f17b1804b1-471178a8245mr197432875e9.18.1761297578559;
        Fri, 24 Oct 2025 02:19:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPRojaApcfmKLinZI5+an6nxl1x1LRwFmTf1gBlrYMQPX1+RmkaC4nUCtM8shmyfMR6tCbSQ==
X-Received: by 2002:a05:600c:820b:b0:471:1717:40a with SMTP id 5b1f17b1804b1-471178a8245mr197432615e9.18.1761297578143;
        Fri, 24 Oct 2025 02:19:38 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-474949df22csm84324805e9.0.2025.10.24.02.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:19:37 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org, jonathan@marek.ca
Cc: linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 1/5] efi: Fix trailing whitespace in header file
In-Reply-To: <20251015160816.525825-2-tzimmermann@suse.de>
References: <20251015160816.525825-1-tzimmermann@suse.de>
 <20251015160816.525825-2-tzimmermann@suse.de>
Date: Fri, 24 Oct 2025 11:19:36 +0200
Message-ID: <87zf9g8xnb.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Resolve an issue with the coding style.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


