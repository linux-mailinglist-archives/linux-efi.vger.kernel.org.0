Return-Path: <linux-efi+bounces-1208-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 668AE9056CE
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jun 2024 17:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A7A1F2449A
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jun 2024 15:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A3917FAA2;
	Wed, 12 Jun 2024 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V3JJgKLI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7493317F392
	for <linux-efi@vger.kernel.org>; Wed, 12 Jun 2024 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718205947; cv=none; b=u8JOGVlVa/kmYVsQJiLJq5DE3VWN/+QHLNftKZdj+rkgJnwti41pTifvyQ9GALxRBM1LxyiYfNV2KGZPgKIPxF34bQe+PCZxLcMyD9F5O4BYXekYMmSaXKgs3fPSwT8imzuicju55SRG+m224G3aTjTGMyLzx1AdWfk5YL/dZe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718205947; c=relaxed/simple;
	bh=7egEVmqARvJIfEE+eCl0SRxlhG1ikV4BnX7Lif1EyUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNHDKl+DrXb1t44/y2HF/5E4wD71HXM9POQ/z1saEQPKbfn8hErr1HixT4jXYUtefIYbxQ1coUr6dX0AFnlYIcoQ3OVtNmg+px8hWw/jgdZh9LqouHxFtGyr4fs6NS7lfk4OvCzE7rjMYIw363AtURxIPxSair3D/I+VtZu1PQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V3JJgKLI; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-518948e1ec8so3754e87.0
        for <linux-efi@vger.kernel.org>; Wed, 12 Jun 2024 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718205943; x=1718810743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7egEVmqARvJIfEE+eCl0SRxlhG1ikV4BnX7Lif1EyUc=;
        b=V3JJgKLIyMp6S41X3oM3d4rEVvfIhSoatC9XfN+K5iLx33fokHBflK65wTByxgT5hb
         IIwslY/JIdQ+rux75NK2Fm3gIgofduCc6PEbEwlKk9v1rp9dLZ6CvAZvTwKeHrTxa3kZ
         CKa7t2QzRpCJzv8i4sXo5ARuSjku1mPc+17htk0xw6vowBdejTtvTWy4kTQigBKL4RId
         unohUaunTYfGdbhis+EqBnHztCOVeLm8055NnxZTcAf/2V8bf9iIxE3Pi7EO2sLtuFlL
         Hwc4u6JIIRCuLmfeAjHYEtgKEjsSSqM3XghVPvSxKMoVfBAJ07szWE8MNGHiv3wptzC8
         RP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718205943; x=1718810743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7egEVmqARvJIfEE+eCl0SRxlhG1ikV4BnX7Lif1EyUc=;
        b=hv9gLQqFiQ9WuyEinOoE6mTL6bkCGvzpQxJmNkRw4F4/WZsXPYUYbVeoaHlrJugXPF
         f1jVKKj9ThrayEzkO81m2zBBX9L6mmov460zAZC7uFs/r4EDJux0iPtU8MFDiPiPgMcv
         HSeheB09/CeJn3CK/As+Iu59SeD8PglUQZFdQGFX4ax0BSqd0EJMIG4jumv7TPBYdnrK
         BuCWbgUlPrXTmv884RSr//i1Fs1g2YcGAG/3d6ozopK/8qwuHslaoOszo9dN8aTipNy2
         UM/Hr3U/DLCwBjOlTgu418m/RklmVu5BiG7RyUfak6xNcErVyQVyJHDwKxOcKDQtqfT0
         o17g==
X-Gm-Message-State: AOJu0YxVpMMuFZgklv9wN8ddYDM1v1tPZ+ZBe/9EWRLvG4JmYgZiWvfu
	R0neqyaDXtF6K4QXPKdN1djJiYN1CMuWna0nAB1wzrCWvO/A0++xAOmY3M84BNcrqTOl5Ew1T1Y
	xOhhCpzCSK2jTL4DyHMztpgGmtB2Xj4lnM2uf1dMvh8DHnLDYrQ==
X-Google-Smtp-Source: AGHT+IHEyeO+zii2ujo2DHpHv4Mzz1bghLggarF8i8Qqy458FbYJ66ZkmB9uvYVWmgU+eFLsr1OgXDhi6sjqB9nboh8=
X-Received: by 2002:a05:6512:3a88:b0:52c:814b:9ef3 with SMTP id
 2adb3069b0e04-52c999a27e4mr155459e87.6.1718205943187; Wed, 12 Jun 2024
 08:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAzv750HTnposziTOPDjnUQM0K2JVrE3-1HCxiPkp+QtWi=jEw@mail.gmail.com>
 <CAMj1kXGvdRwboAZZGEvOh2_wFjzhc1OY2F5BBcYJF5ZhT8=Bzg@mail.gmail.com>
 <CAAzv752N7mZ58uzMkaxAFDbefCLSqtLkZBVXXuY00RA+UQ6ppw@mail.gmail.com> <CAMj1kXHuNCexwOZNoqncLdY2NQk8LTZvXztSYmv_kTr1jr2E7g@mail.gmail.com>
In-Reply-To: <CAMj1kXHuNCexwOZNoqncLdY2NQk8LTZvXztSYmv_kTr1jr2E7g@mail.gmail.com>
From: Nicholas Bishop <nicholasbishop@google.com>
Date: Wed, 12 Jun 2024 11:25:32 -0400
Message-ID: <CAAzv753ZHR46sgncZr4p3dXzxQAZpVgLAzGBhJ2nOPNHo1jttA@mail.gmail.com>
Subject: Re: EFI mixed mode boot failure
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Interesting. Does your custom bootloader implement its own PE loader,
> and if so, does it correctly clear those parts of the PE/COFF sections
> that are not covered by data in the file?

Good call, that was indeed missing. Confirmed that clearing that data
also fixes the issue.

