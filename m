Return-Path: <linux-efi+bounces-3201-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E40CA7C03D
	for <lists+linux-efi@lfdr.de>; Fri,  4 Apr 2025 17:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A8857A7658
	for <lists+linux-efi@lfdr.de>; Fri,  4 Apr 2025 15:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950651F3D58;
	Fri,  4 Apr 2025 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fKhYDN4I"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00981A3172
	for <linux-efi@vger.kernel.org>; Fri,  4 Apr 2025 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743779239; cv=none; b=aSFjhm9QVee2dOqQCsFLDZCs702GfgH7S6VHXEs8UNjmjQGI1ehpiY8UzoP+dJSYb/UisE5yW6BtmjHtmGNBqXjnFdQBGBnUNxAaGiJnI7BIW9Fe1EzmZZWX2MLSMUQx/SA9NvYuisfTRj5Vot2jf6qNmtLu09KK6m3xhfZ1jtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743779239; c=relaxed/simple;
	bh=zjH61skezqD/tzvm29Me2P3Co+mAG43uQMEf1jjgfpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/SkHvJ1WJKPvrMlfhS/00f9RsN5l/emBZaiVg+mkHeSNAZYqtVSuc3VTZH4KZiisEckJw5AlKkwwD5SJGTIkZGdhT5gncWYLG2hNbebq60QID4hM648cpWK3VuzLN3pCclY5h22g0bYVMcJY5sNAc9HfL7W1VZDbDClpgEcb2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fKhYDN4I; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac339f53df9so357285966b.1
        for <linux-efi@vger.kernel.org>; Fri, 04 Apr 2025 08:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743779236; x=1744384036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjH61skezqD/tzvm29Me2P3Co+mAG43uQMEf1jjgfpU=;
        b=fKhYDN4IWujKw2EwXewviOKx7np1F1bTg4uXGipT82BkDEecyDAxNFguvM1/WqEg5n
         Kz1ZM08Fq2DhDCiW9v15l7MHlSSqKPa2Yx4dE14i2/qmUkYRQxYiXjKzcXO55EnpI/dl
         w4+Rb+T+6q6Tt5O2+e1OevxaqnooXHjSQ2+d62HtzveGgBgpELfJ/KXJ1agP5RwsYDot
         whE4LAKy4XsyTWE+k9d4S84L0jFkUrCUhr9jGfBsRAnY1Ws9WKXZN76E0P5sROXC3z22
         g44t+dtW91Jfesjh5iiLrAidw6dAcN0y7gYofv9fgOHzqTHUfBlu/NFYs3wMAEMpG+ND
         cuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743779236; x=1744384036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjH61skezqD/tzvm29Me2P3Co+mAG43uQMEf1jjgfpU=;
        b=mpD7l7AkeUdIZZY86vas8S/vn1V5b8D4QoSrvC18Dg65FmbuSuXbLg90XfYGP+A7Nj
         AR5z47sBwSjRqgvALnCcfb/GYM9fUNTsdgZCG2s4tVgw9cpxGoj2Psdic+pPJcMg+sKT
         DhlJ5gZ7enFrwPcbgYMkKpDD2EiT1BBLOEejasqteaMct7Od+25i9hp2xuBopDWKLh8V
         XfVM6W76R4qKOZSzmRvKXoQPIAHa8bxB2jQAMaHP3f/g7ikUKU9vbunwhu2kBrJxsofz
         gDOSH+Zu9+2AUuTZaVJLbT0weBXT+UJ1l0syWhXie5d43gvvKyC02das2kFjg5EnWBZJ
         mr7w==
X-Forwarded-Encrypted: i=1; AJvYcCUNTKLzI0gZlYXCHv7UfsB2PjEFpOXrnicEpLZfdC1CgPzWEI7UyW9D37JrEOFbU++EsgtUKf5idMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMyv6pPd/V2w7pS4sgdfql4sA0hiRE3LFFfB0hpFzIGc6EANug
	Auk2mZ5uue6qP1sAPxAbzJRuRO6902rfxZqFcV9BOzv9JPCFuiEWVbjh7aez6krt6VI/pZxomsi
	AJ5jbt75y9o2rU7F6t1UATF2LtCae1YY/SfbQ
X-Gm-Gg: ASbGnct3ujnyzA6WroViJarE0Uk4V5jlqHcPePbnKWSn2lI0hctYyMuI/niTtQfVjpr
	DXbTw6cOypssDDMK53JrU5UEuWW3F1G9bsOcKRlxBj/pdmX7nLqa9KZ2WqWhLlLNBN9hjrDqyzf
	oDscT5ikhuq+9o4Njwd0MNR3O3dQ==
X-Google-Smtp-Source: AGHT+IHoHYIgjnTqNf/koXP1ZSa7N4fhejRbYw9l8KvhvhtNeBsuIxWeqajQ7XAq8z7bAk2STRMZANtpn6Q1WObbEIA=
X-Received: by 2002:a17:907:7f90:b0:abf:19ac:771 with SMTP id
 a640c23a62f3a-ac7d185479bmr395006366b.2.1743779235688; Fri, 04 Apr 2025
 08:07:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404082921.2767593-5-ardb+git@google.com> <20250404082921.2767593-8-ardb+git@google.com>
 <l6izksy3qtvo6t6l3v44xhuzmrnl2ijv7fx5ypvaz7kjxvpwhh@4zwlvxyfrp43> <CAMj1kXGwnTkb1bUDaRpkh3ES8thcUVQE7+qgfZQw+RORtvtv-g@mail.gmail.com>
In-Reply-To: <CAMj1kXGwnTkb1bUDaRpkh3ES8thcUVQE7+qgfZQw+RORtvtv-g@mail.gmail.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Fri, 4 Apr 2025 08:07:03 -0700
X-Gm-Features: ATxdqUG8b4-wASJzngQs_3ZF1ziQG91_baB_efphAg_aCiOaBYtqHZwyn4feFV8
Message-ID: <CAAH4kHbxMDGQy3v9ef1ZdqK0TNzpm==BJgx1KiUpRP-CRKDx4w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] x86/boot: Implement early memory acceptance for SEV-SNP
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ard Biesheuvel <ardb+git@google.com>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 1:46=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Fri, 4 Apr 2025 at 11:43, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > On Fri, Apr 04, 2025 at 10:29:25AM +0200, Ard Biesheuvel wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Switch to a different API for accepting memory in SEV-SNP guests, one
> > > which is actually supported at the point during boot where the EFI st=
ub
> > > may need to accept memory, but the SEV-SNP init code has not executed
> > > yet.
> >
> > I probably miss the point, but why cannot decompressor use the same _ea=
rly
> > version of accept too and avoid code duplication?
> >
> > Maybe spell it out in the commit message for someone like me :P
> >
>
> I assumed there was a reason that the shared GHCB page is used early
> on. Maybe it is faster than accepting memory page by page?

This is correct. The MSR protocol does a round trip per page, whereas
the GHCB page can communicate hundreds of state changes per round
trip.
>
> It also depends on how important the memory acceptance is for the
> legacy decompressor - AIUI the use case is primarily kexec, but
> wouldn't the first kernel have accepted all memory already? I.e., if

The first kernel may not accept all memory due to the laziness of
unaccepted memory transitions.
I'm not sure if we have the planned background acceptance process in
place (probably not), but we
can't expect that to have finished before the first kexec.

> it is slower, we might not care if it is a rare case.

If the GHCB is available, we should always prefer it.

--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

