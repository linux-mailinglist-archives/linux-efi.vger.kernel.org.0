Return-Path: <linux-efi+bounces-470-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A018491FC
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 01:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 790F3B22692
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 00:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9840A20;
	Mon,  5 Feb 2024 00:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itIlHnw8"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E47A50
	for <linux-efi@vger.kernel.org>; Mon,  5 Feb 2024 00:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707091694; cv=none; b=sKkzOWxLFZfPMUJOW2kztttCrjKNh9GyQ4gu8N8lzdo1rtRQJPA+Uoy41ZoPeYbWhJNh5Pn88OAmaHTYoOVbmLcOeJnDMH/lsU10WkQ1RERZPezMlTaZfgdoRJwA5ZPjS0Xuy0UUF/Qqo2DjJsbYgqzO4kqP3c0dWwr+Ab9tBO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707091694; c=relaxed/simple;
	bh=+QWbSp08yR1SW1+ItDQvxCBbAqd0m0dp7RmAQ3+sQXU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=b11uiyfhlWPeNKi2BU7azFFn6HGlIsaHj4nc+2a2eDAVFloA+w8ZQIz9NiUI9/bJHf2kO4ox1hUFOYL+h095EndqzvmAEHJvXjzfbjR1C2b7WCqOsNriAGARXOfy7MuvBriJGiwMmiDfHUKM0OwQ9Ji9hAtaFfXwu+q6FX0bnUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itIlHnw8; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so3038016f8f.0
        for <linux-efi@vger.kernel.org>; Sun, 04 Feb 2024 16:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707091691; x=1707696491; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6QkEoYszoJRSyLwrVQhIrMqQjNeFQQpaZ6JD19cATOw=;
        b=itIlHnw8k7KoeQtK//QTMxkgjR6ENaJYyXFL8raTipM011Vw/AcijGSigg8BPGiLxA
         BnPoowoAO0qE6pdivaAnyt34ylw8wjMusVX75Ke71OpvaaC0FND1z+R0JLVZY3Umkyuu
         GfrqMgLTTmoD47Oe8fkxiDCy9BtxiLWsf5bPGV8bhIJjecmhcz38ModbYmTR3Py/Jgdy
         wQ+mpkj+i5C3vxKWbvCfrymS8vDuHTArDU/SuHP1SOqJXJJ+kS7Kk8Dcc3agw5Wy/4+9
         yCNc0McvYT46szplIeOykL3c1DtuUzwDQsbWx0HotU7+Wt2s4cGLT2W375PdNXe5nOA0
         NqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707091691; x=1707696491;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6QkEoYszoJRSyLwrVQhIrMqQjNeFQQpaZ6JD19cATOw=;
        b=C2qcxhyai3mmu1VHWzuUBofJeQ18AVS9frwWmwaZaX7fNiHr1414ZGcMLsoDcztd0b
         D2DGchbC8qa6iQQqW6QtuEZd0FsAUFqdQor3RcaDq32I56hWTI1/fBPBAoK4MJb1Pc+A
         CFB1WOigt3hTYnri8Qwr9bf7QXnJfQHyXVsW2tY0ZLoukR3P8XwyuDey4vH2T40IdRYg
         jhl1kj6/FlL+TucsDNQ5+H5bDXadKZ5mo5CIxQR3FLn2ldQGDqtFGRB96U7f9JpdBvUn
         jKhj3X1ZOz7Ct7j44+nbjmQpHrgayaVzCvuYTzlBG2dCSZx0CXGo0ejhxKnLv6FyOdDi
         6GUA==
X-Gm-Message-State: AOJu0Yzonm8Rfj1MASpOoVO5p7oMz/VOFKjR+8yW9UZ4sa3VErktzEax
	zlXUQCUaq0/d7/gS26OK7u3Q5psyCNOGBMlqMnB7LkXp6QmBGAso0z52AY7k7aEaDYEjU245fI2
	PF1d3bgQZiHTHF84ehN0FQd734QILxc0xk1I=
X-Google-Smtp-Source: AGHT+IEC+l/jq1m6W6/TPqISqbfBaPS06zqv8a7rRQmRNlgnDcb5uiEtzvhMGNx74OVKvgcWGG0fV+VCfKdCSWvAHhQ=
X-Received: by 2002:a05:6000:186e:b0:33a:e44b:8abc with SMTP id
 d14-20020a056000186e00b0033ae44b8abcmr672502wri.18.1707091690792; Sun, 04 Feb
 2024 16:08:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Beaton <mjsbeaton@gmail.com>
Date: Mon, 5 Feb 2024 00:08:00 +0000
Message-ID: <CAHzAAWQ6srV6LVNdmfbJhOwhBw5ZzxxZZ07aHt9oKkfYAdvuQQ@mail.gmail.com>
Subject: Broken section alignment in 6.7 and 6.8rc EFI stub
To: linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Good evening.

Linux kernels from 6.7 upwards (including 6.8rc) appear to have broken
PE section alignment in their EFI stub.

Up to 6.6, we see monotonically increasing and contiguous VMA and LMA,
as  expected for a well-formed PE/COFF file.

In 6.7 and 6.8 these addresses basically jump around all over the place.

At least one loader which is believed to be enforcing strong but
reasonable rules on PE section layout refuses to load these:
https://github.com/acidanthera/bugtracker/issues/2371#issuecomment-1925801292

objdumps of some example kernels (two good, three bad) follow:

$ objdump -h vmlinuz-5.15.0-92-generic

vmlinuz-5.15.0-92-generic:     file format pei-x86-64

Sections:
Idx Name          Size      VMA               LMA               File off  Algn
  0 .setup        00003bc0  0000000001000200  0000000001000200  00000200  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .reloc        00000020  0000000001003dc0  0000000001003dc0  00003dc0  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .compat       00000020  0000000001003de0  0000000001003de0  00003de0  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  3 .text         00b0f4c0  0000000001003e00  0000000001003e00  00003e00  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
$ objdump -h vmlinuz-6.6.11-zabbly+

vmlinuz-6.6.11-zabbly+:     file format pei-x86-64

Sections:
Idx Name          Size      VMA               LMA               File off  Algn
  0 .setup        00003dc0  0000000001000200  0000000001000200  00000200  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .reloc        00000020  0000000001003fc0  0000000001003fc0  00003fc0  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .compat       00000020  0000000001003fe0  0000000001003fe0  00003fe0  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  3 .text         00d6e400  0000000001004000  0000000001004000  00004000  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
$ objdump -h vmlinuz-6.7.3-3-liquorix-amd64

vmlinuz-6.7.3-3-liquorix-amd64:     file format pei-x86-64

Sections:
Idx Name          Size      VMA               LMA               File off  Algn
  0 .setup        00003000  0000000000001000  0000000000001000  00001000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  1 .compat       00000008  0000000000c0e000  0000000000c0e000  00004000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .text         00baa000  0000000000005000  0000000000005000  00005000  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  3 .data         00001200  0000000000baf000  0000000000baf000  00baf000  2**4
                  CONTENTS, ALLOC, LOAD, DATA
$ objdump -h vmlinuz-6.7.3-zabbly+

vmlinuz-6.7.3-zabbly+:     file format pei-x86-64

Sections:
Idx Name          Size      VMA               LMA               File off  Algn
  0 .setup        00003000  0000000000001000  0000000000001000  00001000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  1 .compat       00000008  0000000000df0000  0000000000df0000  00004000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .text         00d84000  0000000000005000  0000000000005000  00005000  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  3 .data         00001200  0000000000d89000  0000000000d89000  00d89000  2**4
                  CONTENTS, ALLOC, LOAD, DATA
$ objdump -h vmlinuz-6.8.0-0.rc3.225.vanilla.fc39.x86_64

vmlinuz-6.8.0-0.rc3.225.vanilla.fc39.x86_64:     file format pei-x86-64

Sections:
Idx Name          Size      VMA               LMA               File off  Algn
  0 .setup        00003000  0000000000001000  0000000000001000  00001000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  1 .compat       00000008  0000000000e8b000  0000000000e8b000  00004000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .text         00e1f000  0000000000005000  0000000000005000  00005000  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  3 .data         00001200  0000000000e24000  0000000000e24000  00e24000  2**4
                  CONTENTS, ALLOC, LOAD, DATA
$

