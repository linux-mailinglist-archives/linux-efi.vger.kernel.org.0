Return-Path: <linux-efi+bounces-5298-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CABAAC25044
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 13:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 36D8635121D
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 12:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F7034A3A6;
	Fri, 31 Oct 2025 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fpIJ5k6j"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965A234D3A2
	for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913928; cv=none; b=eVF9Q1iwfeQROdfjHAbAJm1dTBljQz0E6LAySI/4x/hFgdOFYaUSNXaBiVShFbtaDFWwggXlpnSaLAJ/01/UhlovPb7ecWSpcdUdSY3MIcNvP0nwkrKoKZrdwcwaRsFR38mPFlTqor0WmkrBshqCqEBMmX9vdfMpTJY4oRLs7a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913928; c=relaxed/simple;
	bh=EyUdF6niWEd87pLWTbZVjn7rdZe1vDwhwIQZCMaj54A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5vz7z6vQYvvy+hPdV0sIjdrHl1Jn1kZUp12jQ1Jtasdzl3ClEbyNbSs5k4fCmrShf3UeILJ3zdcJszMfHekU3Wdu/4Rpd/Mqu5ob+U9OPR9pYDEghTUujnGYyr3lrkUFAgVI0vfq3APCPWBcyllCr1XDNI6G3VMnX6JHzMFGFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=fpIJ5k6j; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3cdca2e4ee7so290054fac.3
        for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 05:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761913924; x=1762518724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlQXBrL6GJchLN0rsfCNDqviLGR3waoluveYLsj3WyU=;
        b=fpIJ5k6j+UjSLXI30bMS6EXrrW/4JKH/FEdXHbp2Xj35sEgQH6GH+Uj4P1aO/diTcx
         UA6KpJ06eI9WG39ygQX9prqjGuYZ8PSUS1A+XZDWFRlbfCiKJcumpfNXmrBm3+htAdPm
         H+wJ6ddgMQFgupf5uJcFBA7h1VxM4Fmd5TrPqnzbe4tRHovsH31mSS6s6hXKbcmg0WMo
         a21P8tQHOvmmnA66gXr2ta7wm3iTTZrbwPQD66K1CO3SXBF3oGi/I7oTLL3slsKcGORE
         AR7tJ30tP41Klm73MjOfo054a3fb9e2RASqpv63EmkX4BSTc8+1e0gJ8Btj/HOrv9PWs
         mXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761913924; x=1762518724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlQXBrL6GJchLN0rsfCNDqviLGR3waoluveYLsj3WyU=;
        b=Sq9SOAnKPcoUpvfQbkFR077aCxgEmdLxS+PTPZu1wYArZiCoNPn/ZY/MG2Mkytcdo1
         lbqKqFEnPBAavZBDAtEegR2GrVIl0kVxy4xyYDPR7WI4IvVoBA+n260duu8XMd3Cojf0
         svEeeTaMFvNAC5K+1iCked4nNzOoOrBLvMRVo//yKPsLRtCLiBgVhU6q+lThJvBUgTrb
         PG85NcHvZprBigBqULb6duoCa3Vt4dopPXNjim6ZXGO9QVL81uP13zvjIbhfAfnV3bXb
         /ztICdA56L1+vLXV/B/BvhlbeACKY6ooxnkNvemDzifC1oBZVdvas/vBQNh/sVt8LHy6
         e97w==
X-Forwarded-Encrypted: i=1; AJvYcCX0JS581pmuvK70Q5TwwwAB3aNc4kpVUOo+EjNbH1XGjksQRIBZiKhjXDG9hy9syIhENgOHpnm0N58=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZqZ3gGsS3v7oJdy5X29CvXS/6SAZmXZrMfqnxzuhx0ClPp1cS
	jn3mn5h4Megq+G1RuFdJPtGVsrr7IhUldvsHexUbZsoaTK4tWRgsPaZDRbRLxDkOTeUwB0JmdtD
	+8sMD6pI3NvqYB/58THjm3n+q58jzjleYpTyJTtkA
X-Gm-Gg: ASbGncsBl8rnDfPrKh9IwAuRNT+JLYW4djBOk+UiG9v2ghbpvQB2IqbfT8D4DH32+2G
	1q6C+wE/bK/tqkbFtZGYEsNaqoEuhsNdONoNspBN/w1yJQtHegoS+V3e1pdDht0gmlRM9k9WwDD
	35iCbw/gWusNeqaFbyiwNgQy8x1dVQssEjFu//3CcSn/rwUd6zYy8i2j+rcG5RzGc16qlKqrTbb
	L1PlVdKlI30MPagSEY6ZMBXzJkl3gKfH2oLBA5mpEkaUB29Z0IJ45S76aDknxdr1K+BqicuJKM/
	RGpxC4LZpyOsHfwF
X-Google-Smtp-Source: AGHT+IGYh3c4p7Lro2vb/Mmkwo7ehq0fLSmv/FWy9Te4d7O0xi13T47Zh+2e4+y9v1m45TtVgV5OLaRslqisajSlViY=
X-Received: by 2002:a05:6808:1813:b0:443:9fe6:3bbd with SMTP id
 5614622812f47-44f96061dd0mr676165b6e.8.1761913923931; Fri, 31 Oct 2025
 05:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031084101.701159-1-adriana@arista.com> <20251031101009.704759-1-adriana@arista.com>
 <20251031101009.704759-2-adriana@arista.com> <CAL_JsqJn+vG=FJEnBT2rMQ9Jf+JE2u_j-JpEb=mnWPuTsuz_4w@mail.gmail.com>
 <CAL_Jsq+421HUCRQB5ua9p2UBPi+sq8L0aSYpxVGgJpbpWu2MUQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+421HUCRQB5ua9p2UBPi+sq8L0aSYpxVGgJpbpWu2MUQ@mail.gmail.com>
From: Adriana Nicolae <adriana@arista.com>
Date: Fri, 31 Oct 2025 14:31:52 +0200
X-Gm-Features: AWmQ_bkNOnWH29heQ4utX5bqmSvBneb1mSwkOXqgWEYTPI_SWMnLMKu6rap9SuQ
Message-ID: <CAERbo5x3_+RVRsxY-BZseBPzR0Kkvn7SaSSdoC6fw8a5s5RtUA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: firmware: Add binding for SMBIOS
 /chosen properties
To: Rob Herring <robh@kernel.org>
Cc: ilias.apalodimas@linaro.org, ardb@kernel.org, trini@konsulko.com, 
	krzk@kernel.org, jdelvare@suse.com, frowand.list@gmail.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, vasilykh@arista.com, 
	arm.ebbr-discuss@arm.com, boot-architecture@lists.linaro.org, 
	linux-efi@vger.kernel.org, uefi-discuss@lists.uefi.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 1:43=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Fri, Oct 31, 2025 at 6:15=E2=80=AFAM Rob Herring <robh@kernel.org> wro=
te:
> >
> > On Fri, Oct 31, 2025 at 5:10=E2=80=AFAM adriana <adriana@arista.com> wr=
ote:
> > >
> > > Signed-off-by: adriana <adriana@arista.com>
> > > ---
> > >  .../firmware/linux,smbios3-entrypoint.yaml    | 25 +++++++++++++++++=
++
> > >  1 file changed, 25 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/firmware/linux,=
smbios3-entrypoint.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/firmware/linux,smbios3=
-entrypoint.yaml b/Documentation/devicetree/bindings/firmware/linux,smbios3=
-entrypoint.yaml
> > > new file mode 100644
> > > index 000000000000..4d1521c685ff
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/firmware/linux,smbios3-entryp=
oint.yaml
> > > @@ -0,0 +1,25 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +# Copyright 2025 Arista Networks
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/firmware/linux,smbios3-entrypoint=
.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Memory location for SMBIOS entry point
> > > +
> > > +description: |
> > > +  This property is used in the /chosen node to pass the physical add=
ress
> > > +  of SMBIOS (System Management BIOS) or DMI (Desktop Management Inte=
rface)
> > > +  tables from firmware to the kernel. This is typically used on non-=
EFI.
> > > +
> > > +maintainers:
> > > +  - Adriana Nicolae <adriana@arista.com>
> > > +  - Rob Herring <robh+dt@kernel.org>
> > > +
> > > +properties:
> > > +  linux,smbios3-entrypoint:
> > > +    $ref: /schemas/types.yaml#/definitions/uint64
> > > +    description:
> > > +      The 64-bit physical address of the SMBIOSv3 entry point struct=
ure.
> >
> > This needs to go in the chosen binding instead:
> >
> > https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/=
chosen.yaml
>
> Also, drop the 'linux,' prefix as SMBIOS is not a linux invention.
Thanks! I've renamed it to "smbios3-entrypoint" and opened a separate
PR for the binding:
https://github.com/devicetree-org/dt-schema/pull/177
>
> Rob

