Return-Path: <linux-efi+bounces-834-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5820E885B0C
	for <lists+linux-efi@lfdr.de>; Thu, 21 Mar 2024 15:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57B91F22640
	for <lists+linux-efi@lfdr.de>; Thu, 21 Mar 2024 14:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3B51E534;
	Thu, 21 Mar 2024 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hv5Y/Mlt"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF2984FC5
	for <linux-efi@vger.kernel.org>; Thu, 21 Mar 2024 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032216; cv=none; b=QMkFu6eT+PC2jhrcu9QtFNcxoYMxQagAIhqvZ2m+5gLYFZdFmFbsM2SNE+KRnAzIjdSt3JRw0bjKIqJ7DXNRHDxjWhVcbGpKJ8znr12h05/zjqY3SIqI8kshA2f+21MI5RmmbIyJsOxz6DDdEG+ebNsdg4ds8CAG4Fm4I7GdFho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032216; c=relaxed/simple;
	bh=/D28luKO4+fyZRSYkzsSDtWc+iksLHsvoDCEYnwnTXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSZ0bNJX7McWf/6zdVrXPPsuYHUnT6jb59N2gOCSHmh6E3uO6NMljggIr639ToY2CPw70DVIh5slsKSK8CxWGbp0JBL3yGIzoOWlwMrT0jB9XFRwcTXt0F00RvVTrP/CpEvn7XQ1R5IjbD5E0mFfdyPSIr+yKjR/rSOYKYk8z7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hv5Y/Mlt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4140eed8a4fso104125e9.0
        for <linux-efi@vger.kernel.org>; Thu, 21 Mar 2024 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711032213; x=1711637013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/D28luKO4+fyZRSYkzsSDtWc+iksLHsvoDCEYnwnTXg=;
        b=Hv5Y/MltE+elCaGrdW2CFzfyZy7O3O/b8C87XGJuc6+M0zsFKwNSXbtnCBGkxwwzne
         tFF3zuWEQMVgXJmYjJrs+7DqVlpnvn4T1bGHYQuhHbHjV6WEyF0eBHTCmguwSYhjuet7
         PUtHMtWUvIZgp7S0mSofVaDGFRzjjdV8uS5dCS6nrqyuJ8T2lIiikXQ1cC5ZqfVcND3r
         9ewMFyroKo+pNS41nWZd1yZkVDodZv+B5gMhcppejyWUqPhfH4FT/e88tRaI3STJxpBO
         priy478fh6tfNFhZetTcLvA8GveKGbp8sBdNc4JVne8N4sV+645J9oVsUQiMudrclawo
         gvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711032213; x=1711637013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/D28luKO4+fyZRSYkzsSDtWc+iksLHsvoDCEYnwnTXg=;
        b=g8ijkx2xtmGsaDBOEY/0vbNpGMN5nPq6sepWy0KDg7mCtJRVtMwf/ufFfoKh1hDbDx
         RgKHfbcrnOAjV1wihh8EsttIHNJiidpvpbWwXkoabuotF6xHY/ZLyxSTrKgghbjULpvo
         3/bRtDNt8xqnlytlqDZVJmQVXCvACOJTmwezCsGTWdnIJqFMmvYfCp1zh95C1Q/2ufZI
         REL1hiEQjvkeHqwBk7U16foFi63Ge03wLT7Mnwf2X+l2e7WxLVsjlk0sVJDmn+UjegSR
         NrMjkDBuK5T450A7BMD1CdhdmqCb/Dri2iAAXGwWigvuzt13FOnwiKIeu3ItQfDBTVJc
         lD9g==
X-Forwarded-Encrypted: i=1; AJvYcCXNBQdl9taDSg1Vt4NjXOCusSQjKEUGzsQGMTGc253rh0a4COjuZVmOsOcMFuFJbWxxqGzP3IoKqO/IdPdsWBFMMFp6HgnhnDqF
X-Gm-Message-State: AOJu0YxS8Hh/kcN+3+/2zuIk0ZzIGHUx6clnUQaqmv0UpoWaSMsKe4HF
	mrFcnICUXpbPK4xsSmmMut9suzZPoSMTxbW/n3qVUq38II1GLpOcLKPzAOw/oKKo3DzExSdhJaD
	8zbZ0G6YxT2bANfbry+jOlHxqpILqEI5vjNOP
X-Google-Smtp-Source: AGHT+IHnrzU4oucfhBLl6rdWusfmGBuKU2FAwDwrqL/zW5LP5tQFnHqv1UHWVy4naHflA0A3yOMpuY5i7pnie4PGdpo=
X-Received: by 2002:a7b:c850:0:b0:414:1ee:f375 with SMTP id
 c16-20020a7bc850000000b0041401eef375mr234376wml.0.1711032212914; Thu, 21 Mar
 2024 07:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+eDQTFQ45nWGmctp-CkK=xXXQQHc_DTkM1iN4m-0o5fCjt8VA@mail.gmail.com>
In-Reply-To: <CA+eDQTFQ45nWGmctp-CkK=xXXQQHc_DTkM1iN4m-0o5fCjt8VA@mail.gmail.com>
From: Ted Brandston <tbrandston@google.com>
Date: Thu, 21 Mar 2024 10:43:05 -0400
Message-ID: <CA+eDQTEiRyddZYwmyX3q+1bBgFRQydC++i4DDbiQ+zC-j72FVQ@mail.gmail.com>
Subject: Re: efivarfs fixes without the commit being fixed in 6.1 and 6.6
 (resending without html)
To: ardb@kernel.org, linux-efi@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org
Cc: Jiao Zhou <jiaozhou@google.com>, Nicholas Bishop <nicholasbishop@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi, this is my first time posting to a kernel list (third try, finally
figured out the html-free -- sorry for the noise).

I noticed that in the 6.6 kernel there's a fix commit from Ard [1] but
not the commit it's fixing ("efivarfs: Add uid/gid mount options").
Same thing in 6.1 [2]. The commit being fixed doesn't appear until 6.7
[3].

I'm not familiar with this code so it's unclear to me if this might
cause problems, but I figured I should point it out.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/fs/efivarfs/super.c?h=linux-6.6.y&id=48be1364dd387e375e1274b76af986cb8747be2c
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/fs/efivarfs/super.c?h=linux-6.1.y
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/fs/efivarfs/super.c?h=linux-6.7.y

Thanks!

