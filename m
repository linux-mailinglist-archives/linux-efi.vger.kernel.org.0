Return-Path: <linux-efi+bounces-3233-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CADA7FCF6
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 12:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46441889043
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 10:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EED267B7B;
	Tue,  8 Apr 2025 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmhCnNJz"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F235D267B77
	for <linux-efi@vger.kernel.org>; Tue,  8 Apr 2025 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109308; cv=none; b=hWSM1GgCCf3N4QCYKPaVpxZSoHUBKiTgTSPekRrOhzs4tEpJClje3+EPWsG6nE7Qy4eogv2awij/3vV0RLVzV83BJNHdosAcDUognUugbwQoqDxQIWJAGiAehClD39H9HnFq1ISHOWzkMUJukXUbavx4a9qkL6DCRk9XljdAifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109308; c=relaxed/simple;
	bh=0rdc55L3ynVNr/1iTWWXm5k5Bh7o1p2OsCzJmg2DBeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z2xjSxhqr4bSwF202epnfNVvRuuT+VRAxM5+BBhxtuYcSq+RSxPonMBWmKuKQKnjWi5TXvH5uFU95v0oxAcgMfQdcLogB4q9NLlCRMFJ3mEhPOYDpsCLu+r4iTROq8LlAbYhr5rvS9T+CEfEGs2/fjQQJylh/+WHqkncvuMpxmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BmhCnNJz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744109305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5x8ztklRj+hcaxqPRCHP3RYpTBH39TiiFhtTkJ0tSc=;
	b=BmhCnNJzpnbAmkdDU4L86yRAeS96Hd57R9RD7re3LJHReHubFIArKHcvQp19BwTJSJqEgw
	5WIwrW1vEiSd4GOlm5Ss/ZDKbwIvQPq/ECPL+N4c0E79F+u5/T46spYK5GV9m9lRFfjkoU
	6t1a7Eoken6pxoPyyy59ISzQkQp7gzY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-6p1JRkTEOky9Ya3AkAKHpg-1; Tue, 08 Apr 2025 06:48:24 -0400
X-MC-Unique: 6p1JRkTEOky9Ya3AkAKHpg-1
X-Mimecast-MFC-AGG-ID: 6p1JRkTEOky9Ya3AkAKHpg_1744109303
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d4d15058dso38004815e9.0
        for <linux-efi@vger.kernel.org>; Tue, 08 Apr 2025 03:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744109303; x=1744714103;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5x8ztklRj+hcaxqPRCHP3RYpTBH39TiiFhtTkJ0tSc=;
        b=o18JjiAFr7dVz2+rRT7/6alFH8FLvIARxNQH9XVhUQb1BpI824IcjMLy3c2x+kGI2x
         AL4YNPBp5d1a6JAZluqX2fLkSeHRsgaUdqjFdKB4AVe7ONWzjj9lZaFerUCLcttHGDQL
         ClPBi5olyRzR3E9sctBwpDfWkR/A+r44gcXkehQx29KEsq6ZfscqeV3s3SkqGOW6MuO+
         Z6Umabx1bEbWjUwkC2gwWxkdzVYnrgZTa6gs/opNvvG6ZoBeRob/rOQ4Gu6usZemQShK
         k4+YGFg0ZUnb32idf4EGn+e2uuzJW7TWkdG33CIckEzsHdkM3e1jRygAScKspVPoZAAG
         61Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUd3n2xdvW7JqLb8Bzea+MQ6SM26Cj272JoqWWttI1yvx7qbDfaOo8mmDC6DweYEpg6x1O9HMYAbkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4g4zWRMTWyzWDhojG/Vrvfd6yDWXZAAl7ca2/v081Q6S3Jupj
	b0xy8hY9z6Rfkb3pPkk2Uky2BK9JWZN4rUXrMRJaWE+I+/lxJMI1sZcfMBR+Cg3WmtXLOmZt1wO
	uGScDOLVqMHjbkbiJhH6Zqi/zS8L6h81mN9WDNHaU1JGqSnCD7il0CT59/w==
X-Gm-Gg: ASbGnctE1QWh7eRArM78K1Scq90dSMmYOeKeAA2iPaoJUu//9HtwCsQHagrQprD10lB
	S2dZWcI5DeyJyclLbATg5yStNbeWWhzkDPcu+ZCkkdDs2IP8zMkOkxv6F1cJ1QXOLt0bGIx4IMi
	Kgn3f3N1rmirl2EnnnOhEGmTkFK320CLm65ZrbHI1F4Rr+cBribIR+KQb4+LCbdh0nFLcwtSuMj
	v4ohN84/qutvkgkMlbPw3UqwZB4SDIYZuhA9f8OGZ8rofa3X+xylQQgVNMRjx1iuxdCvYUBYdrc
	kx26Tak67x1wuniZD9dMD/2h67dSw1m0Ul9OLsox7AG9kj0gkU4P3hu5vjX+foeNzETQAq9NPw=
	=
X-Received: by 2002:a05:600c:500a:b0:43b:ce3c:19d0 with SMTP id 5b1f17b1804b1-43ed0da06f1mr141448595e9.29.1744109303223;
        Tue, 08 Apr 2025 03:48:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPyvr9IC5YPwrbteXJ5HIsOUrWufQQG1ons9V7EEJ7Y1tjpgMs/bSQiqMrHaDIkzT80gnIxQ==
X-Received: by 2002:a05:600c:500a:b0:43b:ce3c:19d0 with SMTP id 5b1f17b1804b1-43ed0da06f1mr141448445e9.29.1744109302834;
        Tue, 08 Apr 2025 03:48:22 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1795db7sm164592015e9.25.2025.04.08.03.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 03:48:22 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org,
 linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/2] drm/sysfb: efidrm: Support module builds
In-Reply-To: <20250408091837.407401-3-tzimmermann@suse.de>
References: <20250408091837.407401-1-tzimmermann@suse.de>
 <20250408091837.407401-3-tzimmermann@suse.de>
Date: Tue, 08 Apr 2025 12:48:21 +0200
Message-ID: <877c3v9bey.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Make CONFIG_DRM_EFIDRM a tristate to enable module builds.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


