Return-Path: <linux-efi+bounces-5293-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B352C24D27
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 12:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4A13BB2EB
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 11:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40567346E7C;
	Fri, 31 Oct 2025 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwcegOPh"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B813346E66
	for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911031; cv=none; b=fLrMI/hQ1gguQp2+4MtWjKDStXR7NOe5JeFglf28FPIHGcxx8LIQ3Bd8RVsXERr0T69VTywBOymkDQE817V0RgqCY9nOl0sOz65pltTCK9bOwTsM2Z4rgGgvMrnGmst8m9R/wjFeGtIg/oPqmriv++9fXXvp4LdnlC1Q3hF02Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911031; c=relaxed/simple;
	bh=mdzbrJ0J4uL7MKIWBphzIXl1JweK8UJmEopl7jTNs98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpLk+hRp4dpJo0kt7WZdklj+g4olmrbEF4AIKctjcsIcYwwb5DFpy+FF4N4/mUSEttnp8Yi4v1oIzQNOi1K7haD8hPPL1cI+AvzfY2AQYinkZGAnm/+kQdR6kCEgd4cIqaJ3lxCqHVL+zBV6zHJeeebX9rlle4b/b01X6memcYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwcegOPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE16AC4AF0E
	for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 11:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761911030;
	bh=mdzbrJ0J4uL7MKIWBphzIXl1JweK8UJmEopl7jTNs98=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CwcegOPhjADnfYMsBl9VJU8444Zi7r5+Fje5jBkuUyLoW69fzojXbH1oiTz8pXuqp
	 HmsUdiup+rEVmPdCxf2wJsyNy1pSAzr+EEm3Q4rdtbKf+Wq6CGNdAKbWtrTZnDMeOZ
	 7kLvmgDlrRhAJBhuo6QgCQGV+jnGR38aJUfnUJ7mjdfWeLO5eT/AmgEc+q6bei45Sm
	 zzeH3qZU2/5r3+YN2tdTiizgDzm/Pp8g69asdZ4jZp2CBjtZDBTQGJG+zZPZFsxT7t
	 uNpIfbE2drxVRkVhChnwqGFYQN/uz+8sDVrXvbnphNz7pRIaTdsBPimhP3ScjGu54Y
	 LFul/DdFP3daw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c2d72582cso3587532a12.1
        for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 04:43:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVm3OGLFHrzfXT+ZXGF0g0eQcIFdRpyY/JNC9yhf3prbSscvNZPn/Z4dvIaqaTQEZA15q7ecHPUBI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy565V8SgnaGbExlhn9XAlYw2AdAzCOpKapKdvuY1Sl5kjTNX9l
	N18Ag36cW+j81MifhX6x2OItg+vWcbmb1OZQUlDPxYDELsFb+7tchAv/D5ckB1fwr9Cym6NxTCV
	ySKpfVJoy0Q2s+tWC7sTixbNdl+r+4Q==
X-Google-Smtp-Source: AGHT+IEjMLK6OGl40HXHsXuGaAqP8D5LU+eugA99cHMlpyBU1ppcLNLQ3ZkPtjQ+CzfsdfP4X7J227AIT9NzZ3oM/mQ=
X-Received: by 2002:a05:6402:2744:b0:63b:f59b:e607 with SMTP id
 4fb4d7f45d1cf-64076f66d22mr2833156a12.2.1761911029322; Fri, 31 Oct 2025
 04:43:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031084101.701159-1-adriana@arista.com> <20251031101009.704759-1-adriana@arista.com>
 <20251031101009.704759-2-adriana@arista.com> <CAL_JsqJn+vG=FJEnBT2rMQ9Jf+JE2u_j-JpEb=mnWPuTsuz_4w@mail.gmail.com>
In-Reply-To: <CAL_JsqJn+vG=FJEnBT2rMQ9Jf+JE2u_j-JpEb=mnWPuTsuz_4w@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 31 Oct 2025 06:43:37 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+421HUCRQB5ua9p2UBPi+sq8L0aSYpxVGgJpbpWu2MUQ@mail.gmail.com>
X-Gm-Features: AWmQ_bksFTqLinpU8zo27uHAZknvhm2S3I_vjliyAKm5aA1q3yssJinkZOpFVlQ
Message-ID: <CAL_Jsq+421HUCRQB5ua9p2UBPi+sq8L0aSYpxVGgJpbpWu2MUQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: firmware: Add binding for SMBIOS
 /chosen properties
To: adriana <adriana@arista.com>
Cc: ilias.apalodimas@linaro.org, ardb@kernel.org, trini@konsulko.com, 
	krzk@kernel.org, jdelvare@suse.com, frowand.list@gmail.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, vasilykh@arista.com, 
	arm.ebbr-discuss@arm.com, boot-architecture@lists.linaro.org, 
	linux-efi@vger.kernel.org, uefi-discuss@lists.uefi.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 6:15=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Fri, Oct 31, 2025 at 5:10=E2=80=AFAM adriana <adriana@arista.com> wrot=
e:
> >
> > Signed-off-by: adriana <adriana@arista.com>
> > ---
> >  .../firmware/linux,smbios3-entrypoint.yaml    | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/firmware/linux,sm=
bios3-entrypoint.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/firmware/linux,smbios3-e=
ntrypoint.yaml b/Documentation/devicetree/bindings/firmware/linux,smbios3-e=
ntrypoint.yaml
> > new file mode 100644
> > index 000000000000..4d1521c685ff
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/linux,smbios3-entrypoi=
nt.yaml
> > @@ -0,0 +1,25 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2025 Arista Networks
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/firmware/linux,smbios3-entrypoint.y=
aml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Memory location for SMBIOS entry point
> > +
> > +description: |
> > +  This property is used in the /chosen node to pass the physical addre=
ss
> > +  of SMBIOS (System Management BIOS) or DMI (Desktop Management Interf=
ace)
> > +  tables from firmware to the kernel. This is typically used on non-EF=
I.
> > +
> > +maintainers:
> > +  - Adriana Nicolae <adriana@arista.com>
> > +  - Rob Herring <robh+dt@kernel.org>
> > +
> > +properties:
> > +  linux,smbios3-entrypoint:
> > +    $ref: /schemas/types.yaml#/definitions/uint64
> > +    description:
> > +      The 64-bit physical address of the SMBIOSv3 entry point structur=
e.
>
> This needs to go in the chosen binding instead:
>
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/ch=
osen.yaml

Also, drop the 'linux,' prefix as SMBIOS is not a linux invention.

Rob

