Return-Path: <linux-efi+bounces-741-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E7B873697
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 13:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056251F225BE
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 12:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B928D78668;
	Wed,  6 Mar 2024 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UFrgzxrL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C288592D
	for <linux-efi@vger.kernel.org>; Wed,  6 Mar 2024 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728635; cv=none; b=C/DFSLMdj2bKqQ704qw7c5iAjNzwLIrp77xpingO2oFdNNsNgH/061HywYK8xw8ANt5jRqOCx309vBFUR9KRlxeDeab4RVRpw+imNuMQv2Pm/FHbRqgn9JoQy2oYUHUysoNcmp9HeuJnOmLrK8mN67kvPAaDoM3R25TRMbs4Qgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728635; c=relaxed/simple;
	bh=2cqPFlsh8Bco+kqxKon0TchX/KllK599k66M4CaX/as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lg7SUANmsPNn23sqo11QC/qdyo5eKszTuUKOnaTxAO87ImfU30dGVvaAJmoB7qjfGSdnU/PCd1yjBtnY5LQVqKuJz87VtHkj85PIJ4NifpM3K/HTGJJkwel3fy/1LM1+MS4XJ5yR57LbaO9aDePadASueegLk0K9Hy3V1WFN2Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UFrgzxrL; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e4fb3a2687so596052a34.3
        for <linux-efi@vger.kernel.org>; Wed, 06 Mar 2024 04:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709728633; x=1710333433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cqPFlsh8Bco+kqxKon0TchX/KllK599k66M4CaX/as=;
        b=UFrgzxrLG3TWZXFOpLxtUDARQtTXUtZFYzwNOvuHswiI4Ovt4B4cHUrsm6ptwdssRr
         FqFqCU9fSEcD+NKRtGz3GXLLAOnnZtrTQaRvnwOJ3iNZLAm0EexTCAJoakK7UVUQIeka
         tm85K0c49Jhb7ghgvguRsbdHd8w+dqzVdWohAaRQQvCwU3ZnkSN671mpwnpKpX4eJ4z1
         LRe5skY2W0Dk9ZFKXIKEGF9D+Vs9nPw8M1ZBixJlaCGmUwFe1fO4wnDYrIKCm7VVTT7b
         GhDqvVrgPlF4oyvnKu3U47/J++zJHUxdUBJJKzstQ3Zy0wXk6H9eksr/FBJlJDzOzgu4
         nYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709728633; x=1710333433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cqPFlsh8Bco+kqxKon0TchX/KllK599k66M4CaX/as=;
        b=Bb0OZBL9diKMxD4zJhWtSTsEQlIxJxY0aRy3yy8BpApP5Dinf/YAikKQiCyFYpUKC0
         Ys6UU5XXs94k5Pgn8C3TQ8GHhz46F4pbgvFLIxoGmlVsWpKPyItXJ7zbE3F9qkMDZsjp
         ZzrBuwuQSYFkLq+Q7RPNd08FpHMquu0bcB8gd8mwXu7NreLw44Tie//vzP0T0wfIgLhW
         zxQ1jNtdAyoNKgIMTVp0FlKrqaN7fpm6ah6bGq/odPJyH77NcPCMZGo2F9tznNGKjW1E
         x95NeeyKs1B+IYDv7OGd+ToShI93DfAr6WVKBwCbrgFMKR+W9NKq4uRKIz/L380Ke0bU
         hP2w==
X-Forwarded-Encrypted: i=1; AJvYcCUVh7UN2pDCgCbb7KFFhHl0O/EG7MVWMnqhJxFybt7G88OmN8XprpTCA3hVxPyzAyWTrEKyXNVdhiXBGZht3NXBeVbwLPk8d2yT
X-Gm-Message-State: AOJu0YzjP6ELpbow8Ckmmuv7LLyt3cBqkc3eIOCOWiI3ej3F367F+UVj
	VYDYKf0kaQJov/2eh5mbQa751SqGRVb0wNIbPzYZJQJVkRCyPkV95jWnwBgE6UpnVfRGOmVy+Oe
	v0cLj2SxakDepTFPhhjY/E763CShrf+FjcQuNmA==
X-Google-Smtp-Source: AGHT+IE99raarX6q+utNID5LMaWjIBjAFxPBWNfijTCMPlLwR+cdCHTSC7SvbuWgUttE8dJ1rgbsjINE8A+w7wLhOCc=
X-Received: by 2002:a05:6870:63a6:b0:220:be60:b6fd with SMTP id
 t38-20020a05687063a600b00220be60b6fdmr5349995oap.13.1709728633345; Wed, 06
 Mar 2024 04:37:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085622.87248-1-cuiyunhui@bytedance.com>
 <20240306-zippy-magazine-9a4ecfe1758a@wendy> <CAMj1kXG6k5SZDYwdxhoJDiNxUuAqBOqqANUiys4YTCk_HCF5AQ@mail.gmail.com>
In-Reply-To: <CAMj1kXG6k5SZDYwdxhoJDiNxUuAqBOqqANUiys4YTCk_HCF5AQ@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 6 Mar 2024 20:37:02 +0800
Message-ID: <CAEEQ3wnb7k7CXaZmNHaqCVH7OjY3dX7yn9G+KB7dbuGmm_WB=A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/3] Revert "riscv/efistub: Ensure
 GP-relative addressing is not used"
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, xuzhipeng.1973@bytedance.com, 
	alexghiti@rivosinc.com, samitolvanen@google.com, bp@alien8.de, 
	xiao.w.wang@intel.com, jan.kiszka@siemens.com, 
	kirill.shutemov@linux.intel.com, nathan@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ard, Conor,

On Wed, Mar 6, 2024 at 5:38=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Wed, 6 Mar 2024 at 10:03, Conor Dooley <conor.dooley@microchip.com> wr=
ote:
> >
> > On Wed, Mar 06, 2024 at 04:56:20PM +0800, Yunhui Cui wrote:
> > > This reverts commit afb2a4fb84555ef9e61061f6ea63ed7087b295d5.
> > >
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >
> > Reverts are commits too. You still need to write commit messages
> > justifying the revert.
> >
>
> Indeed. Also, please revert them in the right [reverse] order so we
> don't inadvertently break bisect.

Okay, I'll update it in v2.

Thanks,
Yunhui

