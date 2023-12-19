Return-Path: <linux-efi+bounces-254-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555DF81852B
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 11:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093AF1F22D7F
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 10:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9562614A92;
	Tue, 19 Dec 2023 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M74r9xCB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4124114A81
	for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-db4422fff15so2537963276.1
        for <linux-efi@vger.kernel.org>; Tue, 19 Dec 2023 02:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702981028; x=1703585828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwKtmUeXSXGux8LEEI/VvN8eUqwl+pKEHLAxCiqGfVM=;
        b=M74r9xCBOVit7XAtCidxHratzQtv9OvNhLb2f5TNLCN0tN+MaaZJOFRFmVzqHW0nOS
         dfdXPlYMgUcJBumJweBVy4MbjBbA9XAc6S22IG+J0/zlU7DlpwrE+1l+E71Y/KTb/0xz
         J4HMgD++SN/13JBe9Kb8Xph/PjX/cdV+o0v/qiQepN41dk09dfwu4UECEi4W0yIlV1CL
         w+frAzhnVw2JbxA6ojJburpVfZ2yztxPWVykyM1ozb3BsK8++tqgQT1KUONjtz9FhYa3
         R9xum0cgHzWEy0wCFPeMKU9P5QAcUH3PC9bNjGHseE5EJwjbL0FZms94YyT3vpmcLfQf
         faWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702981028; x=1703585828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwKtmUeXSXGux8LEEI/VvN8eUqwl+pKEHLAxCiqGfVM=;
        b=Joyo3mki3at7zKOV9cxDTKzF3Q9MmYDxnQ9xJ33AusufsjW+nXNVsr+eFG9XKWnAuY
         HW4JgIT9V5+gwPKHmB6/osR+2dW7BxIxHgSSBLZrtNfsTyhLufTTWeH8+dPIhSfVKnRW
         5Rev6icPzHfbtz/L+i8N2GigyxJWiAl6Zs3H0VtDL+aLcGtoN5+Ts2X/HKbpOyGXu26e
         /ODddd2MyAX1eyJyQA2i0iWZakhP65ZqmNZsz7QOBoe6evUjP7GC7iWLeoNFxlpbh6mj
         6qi2lmThfRmC6S1/GSd5Ky7DaPk4wOI+yDvORAUOeBdPpNo/hnHY3XxRychhGmG18oCT
         8stg==
X-Gm-Message-State: AOJu0YyUTxlNSSryZiw5H1DSgCRvMfPLM0K9nelGPNRiA7mtWojxkzVp
	Ldv0Gq6bP2aG5kvCxPPBvtQjbNtQhR9v8X17scI=
X-Google-Smtp-Source: AGHT+IEGctgYKKVMu+YuriBCPXOw/L5KAOMG9wLTDWsxAOg5VUoNJUVa/HSTkhiV6wKe747NB9y5LX/zVTaLJh/49tc=
X-Received: by 2002:a5b:190:0:b0:dbd:8d9:15be with SMTP id r16-20020a5b0190000000b00dbd08d915bemr2752608ybl.85.1702981028230;
 Tue, 19 Dec 2023 02:17:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219091405.39867-1-wangyao@lemote.com> <CAMj1kXEPdMBkne=ugR_j1Be8Aeh8jCA_ryHvh8rMA-c27i+RuA@mail.gmail.com>
 <CAPWE4_wydoTWHUYPmALp1oii+=ALVy_BTDUO_1wOo7XmkJ=cjA@mail.gmail.com>
 <CAMj1kXEL2nuVyNq1O=ytrCr3xh3tA6TU6kRFuk07H1EmneRTTg@mail.gmail.com>
 <CAMj1kXFqpJvH0ukOTufsLCTyCk1abct1kaPUV3JTaS6hMb75Og@mail.gmail.com>
 <CAMj1kXFFb3ksR=HCxiWpfhcjRcx-U=XE5LmZ2AMt9K110QpynQ@mail.gmail.com>
 <CAPWE4_wAa5uYEqkSRkJH+V57jNgjUZgFcrrjtRqRDECTCCASyQ@mail.gmail.com>
 <CAMj1kXHLApok+q99a_MSb6korFnV5qhS5fDL6MXhX9F2pSjBfw@mail.gmail.com> <CAMj1kXFq2a+34cPMmq6LP9VpZGrQV0QAGt0=a-r03wczCE+brg@mail.gmail.com>
In-Reply-To: <CAMj1kXFq2a+34cPMmq6LP9VpZGrQV0QAGt0=a-r03wczCE+brg@mail.gmail.com>
From: Ainux Wang <ainux.wang@gmail.com>
Date: Tue, 19 Dec 2023 18:16:31 +0800
Message-ID: <CAPWE4_xOvsJvKNvZHUf-uA_RvDvKL0iFajsGceyhWJu9q0pP+g@mail.gmail.com>
Subject: Re: [PATCH v2] efi/loongarch: Directly position the loaded image file
To: Ard Biesheuvel <ardb@kernel.org>
Cc: wangyao@lemote.com, chenhuacai@kernel.org, wangrui@loongson.cn, 
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ard Biesheuvel <ardb@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=8819=E6=97=
=A5=E5=91=A8=E4=BA=8C 18:11=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 19 Dec 2023 at 11:08, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Tue, 19 Dec 2023 at 11:05, Ainux Wang <ainux.wang@gmail.com> wrote:
> > >
> > > Ard Biesheuvel <ardb@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=8819=
=E6=97=A5=E5=91=A8=E4=BA=8C 17:35=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Tue, 19 Dec 2023 at 10:32, Ard Biesheuvel <ardb@kernel.org> wrot=
e:
> > > > >
> > > > ...
> > > > > I'll queue this up.
> > > > >
> > > >
> > > > This patch does not apply. What commit is it based on?
> > > >
> > >
> > > It based on the newest loongarch-next branch that based on the v6.7-r=
c6.
> > >
> > > Link:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loon=
gson.git/log/?h=3Dloongarch-next
> > >
> >
> > Please rebase it onto v6.7-rc6, notably, this patch:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?h=
=3Durgent&id=3D271f2a4a9576b87ed1f8584909d6d270039e52ea
> >
> > which is now in mainline.
>
> Apologies, I got that the wrong way around.
>
> Merged now, thanks.

 It's all right.

