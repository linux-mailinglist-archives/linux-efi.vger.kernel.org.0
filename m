Return-Path: <linux-efi+bounces-1046-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A3C8C7C90
	for <lists+linux-efi@lfdr.de>; Thu, 16 May 2024 20:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760A31C20C2B
	for <lists+linux-efi@lfdr.de>; Thu, 16 May 2024 18:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFFB156C79;
	Thu, 16 May 2024 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JeXGh+LG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FA94688
	for <linux-efi@vger.kernel.org>; Thu, 16 May 2024 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715885107; cv=none; b=WiouuPxE2cRbTUhPc3YlS7xqMmlme8bjV2picBPI9FJHrJj+RqyqpTapXtQPgMam4O9iUb1329YEZ9UZqONklz+/EvqoEIpcBO09wQc429ZkC78wuKGRrnsrWG64UkNpYM7Zcv56yiWzhsUsLGNCnWarIb/TF5WPxMsHdbY1sF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715885107; c=relaxed/simple;
	bh=ua0sH8yFISF+rwZPw+ODc9OsV/Q84Q1pFnvbPSpizjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9bWcBNdZ4uBYYDw5sK4ZaiKS6b7jmSv35lXSluqoLvdmSUSCXAiWyzXCf8tUDDdF5ZVAPEiCDbBpwFVcVu0pX++iW8axn0yspEUWVxe651E7McAVKihdDLoWNuN5O79vB7uLboXHYdnYEwo48iEmpTA4fsbmYBqyRqd+tPhYwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JeXGh+LG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so74685455ad.1
        for <linux-efi@vger.kernel.org>; Thu, 16 May 2024 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715885105; x=1716489905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1u0A/jvFC/WJVL7Tt9g9n1qwfCwFzV7mLCVMuWvZLc4=;
        b=JeXGh+LGN0Schm8km4tbHxku3VQwzgB3HuXhhkr8hVJcySSuT9rvpSkqZWZwCJ3cMm
         OYCEMpZxn3irrY8NOAGJerRWLZvcuc1i9vRGHovErpj6L2xGbtjOXW3kvLmNoUDwjPr6
         ByOqrPiclAilLoHgmmb1XPeSkf9sJ24iczz4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715885105; x=1716489905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1u0A/jvFC/WJVL7Tt9g9n1qwfCwFzV7mLCVMuWvZLc4=;
        b=l3c9AX6lPUalaSiwCmE/7KpgzHllUrQZ6ETNialsdg4qo84pXAtGNlb+PKYLYgJiAI
         QiG1Bb6kGacr+cHmhDgz+Lo8zM4QKgtAzvnt4GYuSsUl1kqmQVB7ZnX09WGgUPcTu3ZF
         BpRflShowNfAIB5BUyhfulz3NFV32D7Dhb3U6BwTaXwOi5jCX8zK1VCg6CB7+3quQ+jm
         UmgjImqE8pRGpaNXFPawoSmTkHJnW9Gj4x55tcvGfnERk55WRjiRG91vKlfv7T4YavgG
         25tkxLCJeCoURJfHc7xGRwCj3BfCOIW8mKJNV3mC5qG3tHVqe7meZQ8YvOBkSw4XZeUm
         CtCg==
X-Forwarded-Encrypted: i=1; AJvYcCW+adbpBQWyCiZyiafdKm4KAB6TptmhUf7CgbNfVqJpyq4Ci9X/y4ZeJ99zpmcvUUpzfYRZwWIQP81aNildG+3fKXEFxDX+obF0
X-Gm-Message-State: AOJu0Yx66ffpjzdwKlphci3UYHxn9JI0WfxT1RdvDYvkM2Jz7NlBCC/M
	gUml8XlLTC1GZxaFt8MEM38BjE7/rNL8WgKxo9ks8k8DzISo+cbr1MHu59cwuw==
X-Google-Smtp-Source: AGHT+IHR0nuruZsamFp7ocrMNfq/zZwmTWSTKBs6nVmMbL85kUHjdVSPBM0KXVIfHpZDMNCuGJZDKw==
X-Received: by 2002:a17:902:7b82:b0:1dd:e114:121c with SMTP id d9443c01a7336-1ef4404c175mr236312515ad.56.1715885105493;
        Thu, 16 May 2024 11:45:05 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d168esm142177905ad.32.2024.05.16.11.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 11:45:04 -0700 (PDT)
Date: Thu, 16 May 2024 11:45:03 -0700
From: Kees Cook <keescook@chromium.org>
To: "Chaney, Ben" <bchaney@akamai.com>
Cc: Ard Biesheuvel <ardb+git@google.com>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/efistub: Omit physical KASLR when memory
 reservations exist
Message-ID: <202405161142.A62A23A9@keescook>
References: <20240516090541.4164270-2-ardb+git@google.com>
 <FBF468D5-18D6-4D29-B6A2-83A0A1998A05@akamai.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FBF468D5-18D6-4D29-B6A2-83A0A1998A05@akamai.com>

On Thu, May 16, 2024 at 05:29:11PM +0000, Chaney, Ben wrote:
> > +static efi_status_t parse_options(const char *cmdline)
> > +{
> > + static const char opts[][14] = {
> > + "mem=", "memmap=", "efi_fake_mem=", "hugepages="
> > + };
> > +
> 
> I think we probably want to include both crashkernel and pstore as arguments that can disable this randomization.

The carve-outs that pstore uses should already appear in the physical
memory mapping that EFI has. (i.e. those things get listed in e820 as
non-RAM, etc)

I don't know anything about crashkernel, but if we really do have a lot
of these, we likely need to find a way to express them to EFI...

-- 
Kees Cook

