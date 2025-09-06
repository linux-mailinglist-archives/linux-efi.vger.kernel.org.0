Return-Path: <linux-efi+bounces-4706-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 831C8B4695F
	for <lists+linux-efi@lfdr.de>; Sat,  6 Sep 2025 07:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44EB956651B
	for <lists+linux-efi@lfdr.de>; Sat,  6 Sep 2025 05:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871281E379B;
	Sat,  6 Sep 2025 05:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCbJ3j9K"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD2110E0
	for <linux-efi@vger.kernel.org>; Sat,  6 Sep 2025 05:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757138238; cv=none; b=bGhEkjQx7TGrLAKBazy9c8kOrchoau4zTh3lRktvErt5tl0cVTf2e9LNqlD95nFfJJVjLWIEeqMDeA3Q6rOscdBvzN4j+/MKyTXG2eq7BeXiOXN1Uy4DYnYbqQQsoPaMfm6aF4ChlpTeZDbFKLecJm5ljxE3zy0AGQDdmJu3OUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757138238; c=relaxed/simple;
	bh=AJ439lk5DJbvFC67QeZcJ2OWyO/YqyIX6NJn8jaHJFY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hZBZjUmVHjwysRrZKuX5uZYFTwTaksLFj5Jv7XVwz7+gPl83gFXnDS4fKFXm4L+MXqcJ8GWfMeWMwaRRxVeRUkq+RIJTL7I1hboHYieaPG4lkNWi2QdkQPnc/qJ/cXiaco4hdRbjirc/f6KRJpxdbPFboeFVTS2JpIRl7cDW/as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCbJ3j9K; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-72167166718so1337887b3.0
        for <linux-efi@vger.kernel.org>; Fri, 05 Sep 2025 22:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757138236; x=1757743036; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p3Vp1xYANMPe+DXHXWQcbxlyrUqrSXdJB/v9W3yCLiQ=;
        b=MCbJ3j9KmQtVfKcF7ivXftPMMV/bSl5b4BtKQ4voe5PduczNJwe4GakONCid1epHOF
         d8Cs1+qPo2HNMkjj5yu5J7t71FQrONVhAI1NMEB5Qijrg/MVqsiO/QfxadiZLlvJX5Vq
         067QN+N3PhiKvshYts3iIZmFYCMKakf72TkQcfxldM2mFGMtVpoUHBbKLFHNrNhlZEPA
         G3Dc/kUUWKAvEIASAgygPc13aj/jVor4MKgKfoVGJIR5psey8U9PgcHjt24uppSgoz+O
         hCfkwi0PkgqVF4RXTDWD+Q+mo0Ny/aP/srNHatgz3iMOmW7Unck5/G2iqCtJKNIT63Au
         tM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757138236; x=1757743036;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3Vp1xYANMPe+DXHXWQcbxlyrUqrSXdJB/v9W3yCLiQ=;
        b=heb3/v9sO4VIWfztUdigw9Gm47JdyPTiZkYN3CDvAcCxEz/69TsrO/Ufa6yFHuQDJ5
         uPaYepMZKOWGEOhzkkl+MrH0xBhcY1lJp7aK/oqwe2vt4N3fxMMpE2SFozBSXtkKgkWs
         S+dWg51ZYfNdOgttYgn1czRIKkcf/Git1wcD7SoELAR4uZo9eIZeqQ/oT9fJoCEQEriy
         9hzHETMReuuA3onw1yJE6Cy8opXC2dBzuQZhnCneiXgUhpGutAOtlvpXznGb8RL3zxqB
         MfEgaecSIfqMNfxS8agBhHvbILXE41DvHPM5B9OZjKIuCIocoi4Ta1lpORX7nALdP0ur
         9zAA==
X-Gm-Message-State: AOJu0YyzfNNRo3sMDBEjZhw9MKsrDIVNe6ieM9EJv2+YFsqLc3+vL9Mr
	DTrTue1cxDhjF410zV3lfBOVmH1TWA25Lb/d8Ci00qpTcZdn+2LJMgX2nP5Y+iBzlFQL36aWuIB
	Cl4omOy6KBNaAtl8/cW6MhR/WWq7ZJFqfgg==
X-Gm-Gg: ASbGncsr+Djsul3DnBRp44D9qIjlSSzIgMaDVd/vULl9tAPR2ZplsaUH+UY0zduRh+n
	Rf5SE/FPK61gE2Hw4Dm5euHnzDOFQkjECNveeuYnnq0mXpYDfs36KlOu/aAg+YxdfDc8xN1i6Cy
	aor7jPF12uuVVP5hHFebM3ggDibWDieHd47olQUvoAm5mP6z7d3jv5O7hDyNRLOYBw/Uk31OJok
	NEfclOMeRCmAGX+zUqLojXZe5rY5WMXotCeSJBsbc1IUqrBRA==
X-Google-Smtp-Source: AGHT+IG/NgWjl1LvjfeVJs8T2kGkjHNRFYsAnPzgPrEr7MyuJnZXVETIwuvsu71Gk+aN1xK/q3NTLhvEtfxdFv+N6dw=
X-Received: by 2002:a05:690c:4b0b:b0:71e:79d4:6325 with SMTP id
 00721157ae682-727f57445f7mr5925727b3.3.1757138235578; Fri, 05 Sep 2025
 22:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Costin Manolache <costin@gmail.com>
Date: Fri, 5 Sep 2025 22:57:03 -0700
X-Gm-Features: Ac12FXzZOCswT3RlTIC790-ZSS5l7lVrQdgwvIMTBh1-j9dKDg8rv31sRdev-24
Message-ID: <CAP8-FqnVn=dwOhbNHcmZjdM_htr9m-1FPtEoUBGA14EJSVbCgw@mail.gmail.com>
Subject: Secure boot with the (not deprecated) EFI protocol
To: linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

With UKI and the deprecated protocol - signing the combined
(stub,kernel,cmdline,initrd) works as documented.

I've been trying to use the new recommended protocol - i.e. LoadImage
and StartImage, with kernel
loading initrd from the kernel stub. The first problem is that initrd
is not verified - that can be addressed in a
UKI-like stub that loads initrd and checks the SHA against some  value
added to an UKI section,
before starting the kernel - seems to work fine even if initrd ends up
getting loaded 2x. It would be
nice if the kernel stub had a command option to check the initrd sha directly.

What I can't figure out is getting StartImage to work - it will fail
if the kernel EFI is not signed (access_denied).
It works if the kernel is signed - however a signed kernel can be
extracted and used to boot with arbitrary command line
and initrd, so anyone can get a root shell.

So far the only option I found is to build a custom kernel with a
cmdline built-in and not allowing
cmdline modifications. It also needs the initrd built-in - and if both
cmdline and initrd are included
there is no need for a stub, which is nice - what is less nice is
passing the dm-verity sha, or
having to rebuild the kernel every time the rootfs changes and a new
dm-verity needs to
be configured. There are some workarounds for this - but at this point
I'm wondering if
I am missing something obvious ?

The goal is to guarantee that only signed rootfs, initrd, cmdline and
kernel can be loaded when secure boot is enabled, and can't be changed.

Thanks

