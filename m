Return-Path: <linux-efi+bounces-5521-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CCAC5FF41
	for <lists+linux-efi@lfdr.de>; Sat, 15 Nov 2025 04:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 913D54E6836
	for <lists+linux-efi@lfdr.de>; Sat, 15 Nov 2025 03:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0772222AA;
	Sat, 15 Nov 2025 03:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzM3zeP5"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95C419EED3
	for <linux-efi@vger.kernel.org>; Sat, 15 Nov 2025 03:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763176615; cv=none; b=ZXlK6RX3588ecG9p9DYzxnGmVy2F1dzdHzI8Ya4/yl4nerJGApbtYIetU39On2DpHajhSc2nuOPv8BaPEXIV0hi8HAVDi0v8dBRnvQQIaZj8BIzkwxHT+STi+qetG4PgQ0Xq2qG8fHWckI+eYortMXuGFFOHaAF2bUyhLEPTO+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763176615; c=relaxed/simple;
	bh=1dM7txdnL3WwXxhzg0NfITbWJawqUJn8AxOVuQOmSOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqIoGndWKOU9c2yZzIps48+QEu4xhMEHUKjwQtOLKzwsRMFBZyWhFs+f2jZS7davbDbENW7b7mvVqnYBIwKjOAeDHyVrHhEBR3vFGAKr6/5qVCufHehuLN6kLSelVq3UVode17+iB/wNNWPIUT1ZpYVWTBkZxHnFjLUR5cWE1MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzM3zeP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307ABC2BC9E
	for <linux-efi@vger.kernel.org>; Sat, 15 Nov 2025 03:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763176615;
	bh=1dM7txdnL3WwXxhzg0NfITbWJawqUJn8AxOVuQOmSOA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gzM3zeP5FIrXkPRuKUDq0lbVTzb3+XfJowk7C28SobZejzXWN83pXJEcyP4cRgB1f
	 dLzKFoPZ3octPecz1SMSWDH8nHJvzNfXENC3F1yAnCMPP2+Lu33dSvEADZWHigo6HP
	 FX7gf5H3uVur7vI7YK+rnT8AS0H8jzebkxI8WAXvIeSvK8Uyre4RTbMs/fCCMPSk6t
	 WTgALwDvLQ9dDGeEnhR6p6ypXYVRAF3bL9syz5UR4w25zcc99yA0hbY6o+xRCTEfXV
	 QEntL7cSSUzWtdBy9PUvqkczBTDH9p2f37yXcVSi0eqcSYlqWObC3hRGvFbzTybSaN
	 pM6myGQs8xcpQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64165cd689eso6020622a12.0
        for <linux-efi@vger.kernel.org>; Fri, 14 Nov 2025 19:16:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXu5BkzLmQEH8ucs2HeF3Xy2tFN60bluv/3eVEUMWz5GrzFLLcOr6tGPmBek3SyabUWHv8k0GTuzDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzbV2LxIJYYOzpUHrP0D4s2IatHPZFRKFRSLSWy2FWaWye9rN4
	rLrEw1gzjyHWI+zHvHnXJ4BVDA5v8UZl+y0eXw0ti2y2dOBbVBkbMdlyOmYkQi7vYRyrAV5f5TL
	7LbRRMcsnvyy6rCYmMGcG7LsoUdzSXFo=
X-Google-Smtp-Source: AGHT+IEhCFcB8Sc5IPBxNenAIJu3Cub21VKbayDOKy8qEqMDOguZ4v0qRe+zt91ixvviR/N5Gw9ABrYXgf7ej1GR6n4=
X-Received: by 2002:a17:907:94cb:b0:b72:84bd:88f3 with SMTP id
 a640c23a62f3a-b73658ae241mr667286066b.11.1763176613598; Fri, 14 Nov 2025
 19:16:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <jxfb5a2c2qber623l2gwewirwod54bbgfnvt7t7f3jah2ea33g@2uyhy3auzmpx>
 <d9f3352a-1c1f-464a-a8fd-741cd96b5f8e@loongson.cn> <CAAhV-H6m5vszCyiF3qi94cpHBPVuqM2xH93D=gfsQqOSYvC-sA@mail.gmail.com>
 <33612d85-e70b-26da-8460-ea6b9064ce08@loongson.cn> <CAAhV-H5ZSTFDxvm-W1CrgEoQ5d_jw5yVsfetQ_J_qL5pqLtzgg@mail.gmail.com>
 <CAMj1kXGk0udgM67wrWqahqK8H0uE8emQj51SmJey+7fE-FTjdA@mail.gmail.com>
 <CAAhV-H4c=vdNWO0v_mYL2xZ9FYjDyRDvt6f_kV4d8Bh=CRJniQ@mail.gmail.com>
 <CAMj1kXEaxxcWTTANWeEMNjYDymdL5Fxy2B=XBF4RGtteEkfinw@mail.gmail.com>
 <421c08e1-255b-447b-b5e3-ee6544fbefd2@loongson.cn> <CAAhV-H5KsFShDJ_Cxu+1_ces8oojn8+S-7PLmE7aUj8gX5_GEw@mail.gmail.com>
 <32s3lvzfu6jkyho7qenrqbsm5wkgjnzn2imdp6tfwycmyxpzgu@kg5367uxmxii>
In-Reply-To: <32s3lvzfu6jkyho7qenrqbsm5wkgjnzn2imdp6tfwycmyxpzgu@kg5367uxmxii>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 15 Nov 2025 11:16:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H47fzaKcMhgLWWOTxB+srBsg85-eK0LW1vQXQnvq32-+w@mail.gmail.com>
X-Gm-Features: AWmQ_bk1bIi26jaM84_oT28vQ-tc26Bh0XF8H8WDo5TPEOpn0O8V--WlioeejxY
Message-ID: <CAAhV-H47fzaKcMhgLWWOTxB+srBsg85-eK0LW1vQXQnvq32-+w@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Josh Poimboeuf <jpoimboe@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, 
	"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Ard Biesheuvel <ardb@kernel.org>, loongarch@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 2:00=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Mon, Nov 10, 2025 at 03:00:00PM +0800, Huacai Chen wrote:
> > On Mon, Nov 10, 2025 at 9:19=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongso=
n.cn> wrote:
> > > If I understand correctly, I should modify this patch to remove the
> > > changes of arm and riscv for now, do the changes only when there is
> > > a real problem or requirement some day, right? If no more comments,
> > > I will send v3 later.
> >
> > Now everyone involved agrees that the efistub code is correct, so the
> > proper solution is to fix the compiler.
>
> Hm?  I don't see how it's a compiler bug.  It's really just an objtool
> limitation.
>
> > Changing efistub code and changing objtool (ignore __efistub prefix)
> > are both workarounds, but I think changing objtool is a little more
> > reasonable. Maybe Josh has different ideas?
>
> I thought the conversation had converged on what Tiezhu mentioned above,
> which is to skip objtool on libstub for loongarch, but leave the other
> arches alone.  That way objtool behavior is consistent between loongarch
> and x86, and objtool doesn't need to ignore any prefixes.
>
> So basically, the v2 patch minus the arm64/riscv changes.

Hi, ARM64 and RISC-V maintainers,

Would you mind that this patch modifies the three architectures
together (they are exactly the same style now)?

Madhavan is the author of ARM64's objtool, I think your opinion is
also very important.


Huacai

>
> --
> Josh

