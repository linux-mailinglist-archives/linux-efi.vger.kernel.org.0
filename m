Return-Path: <linux-efi+bounces-472-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85BA84949D
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 08:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC8D1C20D61
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 07:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687D710A13;
	Mon,  5 Feb 2024 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnUl+Rih"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0B910A09;
	Mon,  5 Feb 2024 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707118622; cv=none; b=RZRkYOi8DugM9CCCqiIrEAYXrECVPhK6oz9n1dGi94tI4PSYHc/9avwjMuYEGOOgRWXy+I1F9ByRyiJTOhS5mdp5t/2aVD/+sBWH0tbbJ29nu5jji93zzSoeEf6pkTaFaemsrTBwvm804PU2noqC8hG02lCAXQA2iSm7y2xPoZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707118622; c=relaxed/simple;
	bh=BPkGUXb8Db73vyi/iXpd2E7WrpCEy5UHocmk+p6hWB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XbOn3WuHzo14Cdb1MaDYS6lEvY5n1qWN5WjvVYfX7JHpcxjcH4miA6r4cIsuVUuNaZ9cmhp0x8QKvR2FZcSuu+szb3oQX4883sys1ito5442KYWX8yMgoKn+kMFyrNaFmGPjZSIVsoa0gxNHN0lkD8vCbOrBZBfoHHziFYuULVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnUl+Rih; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fdc653665so3305485e9.3;
        Sun, 04 Feb 2024 23:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707118619; x=1707723419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BPkGUXb8Db73vyi/iXpd2E7WrpCEy5UHocmk+p6hWB0=;
        b=XnUl+RihLFNj+jnMGo7C9bjgcciK47TYmSdFgC5L9CQPoziYpRhkAvwQ35ycHFthXs
         G6viRACGoNZ5tpaEL3efhLRKRUlxRO2LS4ISy7WCZSXTkli2I+xiyID0LbH1WSg/kMDu
         66gU9O93Y0nOhTzj8RBlHhpKfO1835k7tliJrWlutY8+YhyThy7Un1zrdo5TkZWcxvdj
         D8FL06lN917kZEd1ntyFV8YV5fAeTzUX176n2GyOOJTd25pjIgpdtexKnOoMacyiaO+R
         gSWNHYcwvMKa717OiwE2PdMufPtUMA6GyL2O6ElBsM75JXDYEXcegsj/4pypZ9EUZsWu
         iojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707118619; x=1707723419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPkGUXb8Db73vyi/iXpd2E7WrpCEy5UHocmk+p6hWB0=;
        b=CSiKKJWE6Jgg7b/tGN2BpzsKqkM6GIw2BGjivpncvJNLW+2ysMIuWiriKwLwa1cujp
         TtWw2iJWGmGUeCUmFlVaRyRXZcqd/oE3udpzVJBaV/4Lca65P4JyUoukkH41bRqYX1bn
         dy9u6EMOEDvie5RBjQ2UvRPncBzb8MmYOf4mNSPbvtPLLs47jGl7wDd0o3nETCEiVoTr
         kjcVbA0ASX0lMiOuPM/1EgXRTsooJpNzp1MJoj4YYEVTCr9dLW+YlUdPDBJsvK3dQ8pM
         NIUPWlXSOx0kOskt/cExAIhGxXTQzKUzfK/X0SPZLVnC4leceBaVBYEfok+QtKsoDdX/
         blvw==
X-Gm-Message-State: AOJu0YwqA3yITWRWGoQKt0yAhg1K0rSIZAvXXuUtxooP5lZGKQShAKBE
	r4mGDqRuzkVyu4rP1qchDHcLHz2/jHzcdFUjWIr0GUvjbmjF3a4wKlZQ3gMf7OY7pu5qdZ7wbks
	O84J3igyJlg8CGutzfmZQl8uYE1E=
X-Google-Smtp-Source: AGHT+IEUuH46zUBSjcPNtg+1yODWUPbBwUbbmWypPfYL1bYGOACxgV8x2ng2cx7wu0Fbxz/yfWihFdEW5eRZe/rq80c=
X-Received: by 2002:adf:f150:0:b0:33b:365e:b10 with SMTP id
 y16-20020adff150000000b0033b365e0b10mr2845843wro.31.1707118618860; Sun, 04
 Feb 2024 23:36:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHzAAWQ6srV6LVNdmfbJhOwhBw5ZzxxZZ07aHt9oKkfYAdvuQQ@mail.gmail.com>
 <ZcBCiqOroolz1hoh@archie.me>
In-Reply-To: <ZcBCiqOroolz1hoh@archie.me>
From: Mike Beaton <mjsbeaton@gmail.com>
Date: Mon, 5 Feb 2024 07:36:48 +0000
Message-ID: <CAHzAAWQ2snWppQK_D3cSR6m35htVqM+4Su9f1JT9oWZ2A9Vznw@mail.gmail.com>
Subject: Re: Broken section alignment in 6.7 and 6.8rc EFI stub
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux EFI <linux-efi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Ivan Hu <ivan.hu@canonical.com>, Jeremy Kerr <jk@ozlabs.org>, Peter Jones <pjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 02:06, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> So v6.7 onwards misses .reloc section, right?
>
> Confused...

Reloc info is still present as normal in data directories, e.g.
`llvm-objdump -p` shows NumberOfRvaAndSizes = 6. Reloc info is taken
from index 5 https://github.com/tianocore/edk2/blob/master/MdePkg/Include/IndustryStandard/PeImage.h#L128
. (I've been told a dummy .reloc section was dumped recently?)

