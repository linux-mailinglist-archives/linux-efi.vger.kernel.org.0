Return-Path: <linux-efi+bounces-250-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EF181849B
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 10:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FAE282CC8
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 09:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E8A14017;
	Tue, 19 Dec 2023 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xye6vNg+"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E591426B
	for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 09:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A358C433C8
	for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 09:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702978515;
	bh=Oq624j/XyNsER9lKT02s4qAbC6BP90dVUevSCbRV2/w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xye6vNg+OGcwwOHFePDHIF0nXZBue7SPxq2KfuUIcVkRLKNzGp/FosVuuJFDkzHN/
	 wx3PLuYxKraz6GBONvx748uzykTjl8seZtOrssa8YXLDCjybFM49U/IC1GImWy6SOz
	 4Z+a69gy1iRqXq9ZI66pQn/e3FSvTXULoHsGIk3FbRkubiRuNW0tZPDqpXeEvui7nK
	 rfeBIuUjBqBEyjp/wo1MUVWJb7zI2SriLjWUu1T6FxOYp9pnfvG9ZzxSn6R2WT48DK
	 S7e/GToRm20FiKOpPOoV8zSRdlvW18Hr2ZUCCc+wRcP+DBrHQRZ4psHq4thfw3d60i
	 1RYi4iR0eSmVw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cc6ea4452cso27231931fa.1
        for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 01:35:15 -0800 (PST)
X-Gm-Message-State: AOJu0YyRmOLFhehTMUHn6Uh+UL6aIghIpwqRsQ5UUI79eRR4fsRlIa1a
	mhKpDQ+D6bf68FZlgY/fJupxeHzc+uWvsZH7MqQ=
X-Google-Smtp-Source: AGHT+IHH6TNOCfVSZ8lmCDk2uh1nc9jVwjqjRvkv87qrhvnJoee1WAOA2QmzYZ2HcoWvwpzl7aSROi2MFMc4QGv316Y=
X-Received: by 2002:a2e:9592:0:b0:2cc:61b6:1e8b with SMTP id
 w18-20020a2e9592000000b002cc61b61e8bmr2162693ljh.104.1702978513728; Tue, 19
 Dec 2023 01:35:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219091405.39867-1-wangyao@lemote.com> <CAMj1kXEPdMBkne=ugR_j1Be8Aeh8jCA_ryHvh8rMA-c27i+RuA@mail.gmail.com>
 <CAPWE4_wydoTWHUYPmALp1oii+=ALVy_BTDUO_1wOo7XmkJ=cjA@mail.gmail.com>
 <CAMj1kXEL2nuVyNq1O=ytrCr3xh3tA6TU6kRFuk07H1EmneRTTg@mail.gmail.com> <CAMj1kXFqpJvH0ukOTufsLCTyCk1abct1kaPUV3JTaS6hMb75Og@mail.gmail.com>
In-Reply-To: <CAMj1kXFqpJvH0ukOTufsLCTyCk1abct1kaPUV3JTaS6hMb75Og@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 19 Dec 2023 10:35:02 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFFb3ksR=HCxiWpfhcjRcx-U=XE5LmZ2AMt9K110QpynQ@mail.gmail.com>
Message-ID: <CAMj1kXFFb3ksR=HCxiWpfhcjRcx-U=XE5LmZ2AMt9K110QpynQ@mail.gmail.com>
Subject: Re: [PATCH v2] efi/loongarch: Directly position the loaded image file
To: Ainux Wang <ainux.wang@gmail.com>
Cc: wangyao@lemote.com, chenhuacai@kernel.org, wangrui@loongson.cn, 
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Dec 2023 at 10:32, Ard Biesheuvel <ardb@kernel.org> wrote:
>
...
> I'll queue this up.
>

This patch does not apply. What commit is it based on?

---8<---
Applying: efi/loongarch: Directly position the loaded image file
error: patch failed: arch/loongarch/include/asm/efi.h:32
error: arch/loongarch/include/asm/efi.h: patch does not apply
error: patch failed: drivers/firmware/efi/libstub/loongarch-stub.c:35
error: drivers/firmware/efi/libstub/loongarch-stub.c: patch does not apply
error: patch failed: drivers/firmware/efi/libstub/loongarch.c:37
error: drivers/firmware/efi/libstub/loongarch.c: patch does not apply
Patch failed at 0001 efi/loongarch: Directly position the loaded image file

