Return-Path: <linux-efi+bounces-1189-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BBF9026E3
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 18:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2382F281CD7
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 16:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38DC14601E;
	Mon, 10 Jun 2024 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WrTBngKL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3241C145FF7
	for <linux-efi@vger.kernel.org>; Mon, 10 Jun 2024 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037661; cv=none; b=WZqe8B4SozL0ynQUROkreFkGh7NGMZrLDIp7IpCqsQsgGHQ+KUqEktc40Dw5ZGwoRzbmlru7sF6Rxf+4Tw8NyvqhX6b1KVOJGHu0L9mCrcETV0TGPllvprWaWMjyG6BkZdIr0X9rRGLHlFuVVWqrhhTnnWayF5xudCuV8Iv2AeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037661; c=relaxed/simple;
	bh=ePhB/SXDu4itPsWgN2BKIBD2B//1GuHNdmetyHb+pjc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CnnhaQNY6G9EQhLoM5v/SVDm0ap40QJWZPkIJkhLuXLi1UuyXa0oHQs1zOUBU3PdtaZpv6mOq2ZzxdrSt/IkyDl1qbPs3Hmd/5Dqh4MtoMGl0EoKuSYIdNG+MftxWgMxYoIsWEO7uSsbYgYeT7f4dy6W1v9jrWGuCLnQ+6l+S5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WrTBngKL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4216d9952d2so2065e9.0
        for <linux-efi@vger.kernel.org>; Mon, 10 Jun 2024 09:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718037658; x=1718642458; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ePhB/SXDu4itPsWgN2BKIBD2B//1GuHNdmetyHb+pjc=;
        b=WrTBngKLZ80X2rq0bsHcbCwTnH3zbcteJA/11SSpgvNiXBxOHv8WmWJWVk9aRC2cPM
         yvVvjGazKfu+4PRkQj47mv2hDoZCT5TCg2J1vba34dcFzsrdzGMjdn/7NIs3uTZRcpvF
         nO7aiT87QR7mY45n6jgjZnUlDXN4D3YnzJzG6w2zyHBuUiT6ScSwpG4bk3MxYV/1MZgv
         fQqauQVVae9jhpq2ljkRrBFYEnybWt5K7GR6DM3blUSgZWRxRoZJl7r61W7fYPo13K6o
         +uqCIr6zLV8tTkT1lwVf9rvyJ3hUkPdSpoW+YEDZZA1AyF5zNQnW3LOBb8QwOS70INCp
         6oiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718037658; x=1718642458;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePhB/SXDu4itPsWgN2BKIBD2B//1GuHNdmetyHb+pjc=;
        b=Sxp+5YZVOjEzJOuNa1lDH8ZvMfY6mJeMIu0K6YjnYg1JVyh9xjjFcSF2PYKBJDdZBe
         MS3Ixx/O63O4+TuQCTVUcvzRSsH+SuOG+9SRaEkUZ4xfBNx8ZcKYKSOqbRAmLHQjtNJE
         vaxNDOg8TDXZdazn/C8vg/+lXmm16X54MgVC9hOsLdYBwrGo1Ze2xUiDbFZ1m/e37svj
         XhqOc0DgfV3fMUC6YSRC5j/5aX8YV2cpKv3Va1Z7M/wvJVU0QSubGpl751Hei2/4GmKv
         4pRkcUDMs9yFJAUH6/l5JD6UqoC608S07FtjoBwbIdV74tN2iZ44Ei6SLw6FU7fxoI9w
         3Lcw==
X-Gm-Message-State: AOJu0Yz4+4MawO6IBlAYUd3d0+4UxXD54Ys1j2PyrR1UQI/dmPHpMBHc
	Wfd15ha7n9h3ZpB2Pj7sCg5OfIYFm5nGVVXAa7eZd7WkvEgYOonSFBffiQesyNX0zREmyRC4+tn
	MeU0842FoQDE/3CUZpSdfCLOihdjOlvcfwMRs6Pq42zxfyEa4kvTE
X-Google-Smtp-Source: AGHT+IHad0Aq7nyoBSTEfm4s3TnX+OZ2eYjg9uRchjWPQbLgL0dvb+hoxz+mT5//ojopmzhAVPGIQRN7Q/raKXX5nqU=
X-Received: by 2002:a05:600c:1f18:b0:41b:4c6a:de7a with SMTP id
 5b1f17b1804b1-4217c0d896emr3340085e9.3.1718037657994; Mon, 10 Jun 2024
 09:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nicholas Bishop <nicholasbishop@google.com>
Date: Mon, 10 Jun 2024 12:40:46 -0400
Message-ID: <CAAzv750HTnposziTOPDjnUQM0K2JVrE3-1HCxiPkp+QtWi=jEw@mail.gmail.com>
Subject: EFI mixed mode boot failure
To: linux-efi@vger.kernel.org, ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm seeing problems booting the kernel in EFI mixed mode (tested latest
torvalds/master, 83a7eefedc9b). I'm attempting to boot the 32-bit compat
entry point, not the handover protocol.

It seems decompression is failing, and some print debugging pointed me
at [1], free_mem_ptr is not initialized to zero so that branch is not
taken. I figured that might imply BSS isn't getting zeroed, which led
me to where the BSS is conditionally zeroed in efi_pe_entry [2].

That conditional was added in df7ecce842b8 "x86/efistub: Don't clear BSS
twice in mixed mode". I verified that prior to that commit I can boot
successfully in mixed mode, after I cannot. The commit message says that
"efi_pe_entry() is also used as an entrypoint by the mixed mode startup
code, in which case BSS will already have been cleared", but I couldn't
find where that would occur. I do see a BSS clear in efi_mixed.S, but
it's gated on CONFIG_EFI_HANDOVER_PROTOCOL [3].

[1]: https://elixir.bootlin.com/linux/latest/source/arch/x86/boot/compressed/misc.c#L360
[2]: https://elixir.bootlin.com/linux/latest/source/drivers/firmware/efi/libstub/x86-stub.c#L479
[3]: https://elixir.bootlin.com/linux/latest/source/arch/x86/boot/compressed/efi_mixed.S#L156

