Return-Path: <linux-efi+bounces-4046-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AE0AECC4F
	for <lists+linux-efi@lfdr.de>; Sun, 29 Jun 2025 13:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A980171544
	for <lists+linux-efi@lfdr.de>; Sun, 29 Jun 2025 11:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0314217705;
	Sun, 29 Jun 2025 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mdxw6OG1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062181D5CDE;
	Sun, 29 Jun 2025 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751197247; cv=none; b=r1AxLmraC9sDFDui6I6D57CvUEPSwtQ+wMxIFtyehcWI4Jm54S6yue9qFKyXxA5snjLointQZ0Iuv+TJag7msWWkVenEzp0udzXHTe5o0FhVwk6r8ANtKjprPyGByB2hArHNhTgKIwUdwoQNFSLUusuWXyjiZLo3WY0EwmorZD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751197247; c=relaxed/simple;
	bh=SuGAcFPJ8fDZpq64lXMcRG2awU6YZOcrXavdp36eUsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CtOC0wXmq3HTQXpRwvwf0E7mktFF/WWnjZy6+T9RayW7GDWqQZhPB1YrSZ/C6ZHrVdUpjDCcIYEwZ80532QW72+gBt2eR/rhzeJR0obQPm7240tPVNBQVB7jgFIJ9eFdf59ViLiLQYqbzLjPelkOcMcnn/7KVWH6Tc7Mpt9VglE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mdxw6OG1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-453647147c6so38539315e9.2;
        Sun, 29 Jun 2025 04:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751197244; x=1751802044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WM9wI+ftSuqEkYEs3zU3TH9PeO5T6PPzLJahZfyDzY=;
        b=Mdxw6OG1p0/SMH0GN6nfsaJc1BABKDOrkozrRWcCdZne6Xw9vTRwzQ+Y2Gj4KWzTb6
         8iRnci/g12EEvdtw2KTGncHNp8y37i4ypNkXX9SO5Q1VyABdiNWKVquMTPHiz/A5xjaU
         CW8c593SSNnTVngexUQQU0dnB1LhF8mbUiVk0dkodj7y4Gb8mAfvkatfi1ZzEe1IL6wH
         BECYlM/+OHus84UvHtyLqiL3KNfCLtnOf2t+LK/SH4Tc6Nf65f1GW0L4/UIDUfWlTHLf
         X6uG5w0/8Qrp1LXyj/zQL6IgxcS3cnCoTvUI1cEypTw9H73PXI1K1BjN/Yz47vTD8pgI
         DTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751197244; x=1751802044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WM9wI+ftSuqEkYEs3zU3TH9PeO5T6PPzLJahZfyDzY=;
        b=jqHcCHpLo7uiuUFZgCkYBtEwpjy9BIqm8XP1Cu31OchreUlHhYGDV3hRT7Odj7kVk0
         1EuY+LV8HYzt6xmsMZ0iD2MeQHf6yCsHnK0dWyIp90nyQPK41zRs0EcJNQiJ9CjG0Anx
         qVgBiZ3em2ptpYRIVffCFKb14wttYBhR9JENjkzq9TqLC5OxpK8M98NIe9vvH2MtV4u8
         NEvDsJFhcVWe/ko/P9XmLYTsWRFxiPO9ADvHr9xqfwTyafOr3zpdkBl/1QC/9yTf8Sl/
         rSdUkj0qCgXKGqSKXsSXmCsU2nohemO2GgWyqwH5yZAhJuKqjBCIK9pJa9Uy1cRblGDQ
         Y+wA==
X-Forwarded-Encrypted: i=1; AJvYcCU4Bz3s5v7KgsscbpAnwBHITmGo3QLsgvs/GuG8E5Fdgn8OfFObjj22pCPW3drqvJk3rPzDNgSA09Y=@vger.kernel.org, AJvYcCWvd4TsM+KfMUkJ3o7HOC7zoCSW2KcvohrBU2ssmCCadg5q6kgUrmbxBoOiH5QN/xFPecCifjpN5BY3UMS+@vger.kernel.org, AJvYcCXEaDXDE9mE8XQC6uNUpWPBXrf0G7JcxAcRrfDP1PoCkfqGavLswvDOxgQ/HWjSX/TFc4qo0EsaU3yb@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhyxz3nv+w7h8ntFEd8VJDlDrS6QI8zyVwaXuKxpMLqwGZksfj
	N7qOofn6vmwKTZO6LfbVgiApnji7U+//j4Q4mhCl9kVGeog4D9ck/2Zf
X-Gm-Gg: ASbGnctkXNwF6wmoGjQh8cPJH9zJG0tmzQ801G3IBZ72muC1Nw+S6OGDXhEYvlOCGgp
	Ah0g95A58PLhaEgDrGdZXa7eI/yY8gsxeWERbnKBRqJS2yDXUYSgzrKc/L6ESzZuf4PG+tnNlIV
	AR04/mFTGetqyg2Y3vMKeWVu4gPzxR6Bq+KG9dbCu7W0gMi4GTg2Lw0FuhknS5XFCo8QHe6GDiB
	v/jLUYWcnyPVpVD5mkkdeKTnE0RROThaVcUbPMmyyoxWni5oy+R34gePdyqi5DjCLGP/X4I5kDC
	Ioc1dY2W6BMqOelEDX0vxCpWqsCLogRnVtqlbWpw3jH0M9T2+ezoug+iUJ071lGCSxf3lPR0R6J
	2XjUTPbVzhKNzpTBeOssnA8diXalj
X-Google-Smtp-Source: AGHT+IGG36v57mIHx9b8wattPhP5PhbXduaoeVXbueE5hKYc+gE5hVGbh4KVH7GNd0aydHy8k2cc9w==
X-Received: by 2002:a05:600c:a48:b0:453:58e8:a445 with SMTP id 5b1f17b1804b1-45396a94e32mr40584365e9.11.1751197244036;
        Sun, 29 Jun 2025 04:40:44 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a390d05sm105209375e9.2.2025.06.29.04.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 04:40:43 -0700 (PDT)
Date: Sun, 29 Jun 2025 12:40:41 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Vegard Nossum <vegard.nossum@oracle.com>, Andy Lutomirski
 <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel
 <ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, Xin Li
 <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh
 <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, Tony Luck
 <tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jonathan Corbet
 <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar
 <mingo@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Daniel
 Sneddon <daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 Sandipan Das <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>, Rick
 Edgecombe <rick.p.edgecombe@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Hou Tao <houtao1@huawei.com>, Juergen Gross
 <jgross@suse.com>, Kees Cook <kees@kernel.org>, Eric Biggers
 <ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Masami Hiramatsu
 (Google)" <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>, Changbin Du
 <changbin.du@huawei.com>, Huang Shijie <shijie@os.amperecomputing.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Namhyung Kim
 <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv7 00/16] x86: Enable Linear Address Space Separation
 support
Message-ID: <20250629124041.04a30869@pumpkin>
In-Reply-To: <ky4an2a4ks55phzuzdvb5py4psvgintt4u2rmthhx44zsx3gqn@uxw3sebzpbch>
References: <20250625125112.3943745-1-kirill.shutemov@linux.intel.com>
	<9b1c5e43-ff48-4af8-9ec8-1c1dc2b902ae@oracle.com>
	<1b96b0ca-5c14-4271-86c1-c305bf052b16@oracle.com>
	<ky4an2a4ks55phzuzdvb5py4psvgintt4u2rmthhx44zsx3gqn@uxw3sebzpbch>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Jun 2025 15:47:36 +0300
"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> On Thu, Jun 26, 2025 at 11:35:21AM +0200, Vegard Nossum wrote:
> >=20
> > On 26/06/2025 11:22, Vegard Nossum wrote: =20
> > >=20
> > > On 25/06/2025 14:50, Kirill A. Shutemov wrote: =20
> > > > Linear Address Space Separation (LASS) is a security feature that
> > > > intends to
> > > > prevent malicious virtual address space accesses across user/kernel=
 mode. =20
> > >=20
> > > I applied these patches on top of tip/master and when I try to boot it
> > > fails with errno 12 (ENOMEM - Cannot allocate memory):
> > >=20
> > > [=C2=A0=C2=A0=C2=A0 1.517526] Kernel panic - not syncing: Requested i=
nit /bin/bash
> > > failed (error -12). =20
>=20
> For some reason, I failed to reproduce it. What is your toolchain?
>=20
> > > Just using standard defconfig and booting in qemu/KVM with 2G RAM.
> > >=20
> > > Bisect lands on "x86/asm: Introduce inline memcpy and memset". =20
> >=20
> > I think the newly added mulq to rep_stos_alternative clobbers %rdx, =20
>=20
> Yes, it makes sense.
>=20
> > at
> > least this patch fixed it for me:
> >=20
> > diff --git a/arch/x86/include/asm/string.h b/arch/x86/include/asm/strin=
g.h
> > index 5cd0f18a431fe..bc096526432a1 100644
> > --- a/arch/x86/include/asm/string.h
> > +++ b/arch/x86/include/asm/string.h
> > @@ -28,7 +28,7 @@ static __always_inline void *__inline_memcpy(void *to,
> > const void *from, size_t
> >                      "2:\n\t"
> >                      _ASM_EXTABLE_UA(1b, 2b)
> >                      :"+c" (len), "+D" (to), "+S" (from),
> > ASM_CALL_CONSTRAINT
> > -                    : : "memory", _ASM_AX);
> > +                    : : "memory", _ASM_AX, _ASM_DX);
> >=20
> >         return ret + len;
> >  } =20
>=20
> This part is not needed. rep_movs_alternative() doesn't touch RDX.
>=20
> I will fold the patch below.
>=20
> Or maybe some asm guru can suggest a better way to fix it without
> clobbering RDX?

Or separate out the code where the value is a compile-time zero.
That is pretty much 99% of the calls.

	David



