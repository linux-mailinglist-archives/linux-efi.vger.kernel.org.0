Return-Path: <linux-efi+bounces-624-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3E685EBFB
	for <lists+linux-efi@lfdr.de>; Wed, 21 Feb 2024 23:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A44283470
	for <lists+linux-efi@lfdr.de>; Wed, 21 Feb 2024 22:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4045086646;
	Wed, 21 Feb 2024 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4E9he3p9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983C53EA8F
	for <linux-efi@vger.kernel.org>; Wed, 21 Feb 2024 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708555719; cv=none; b=WImOI69lBCjjeKTum5eQIYWW2P97SYhrKzPADwhIADCLZow9KcNgO6w1izSCszNPzmFNCaUTZDa5oRg3m2qlgqq9Zd+YF4odj8n0iJWqdC7u4lXvPCgCXCFEZJ5au16U70tXmZTgwOHvqW0IYkdzcKQDhVoCQYiFsbNDxhgjbWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708555719; c=relaxed/simple;
	bh=1CkGcXdG+KrlM+x9gWekq+WBiUkt/eToiyx5uT4ML+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzoAifb3M7o2avZqMOhSWETAOb8QdJyDm5rDkHFkSN69ukjRcbD0UNAnqa0e3XykQSgP/wzUIyXbhz6iB+dq0bz/VVPoKqcKsRBSIa//FJTUMkYWHCS7R6lUH8hzJMuZu6YndTkn1SNUkAGW9MLIaaMFX9ipZgQGxUAM1t4dh/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4E9he3p9; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-428405a0205so54051cf.1
        for <linux-efi@vger.kernel.org>; Wed, 21 Feb 2024 14:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708555684; x=1709160484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gw5fc5I26kdjc0zlKV7SIy+DOj8voXJyqY3HQnL2RuU=;
        b=4E9he3p9Gt5DJ4bz0VKbMtIezXkJVB1PMFthc06+xcYvzk2p8jeO8bCiTaEqPCnlJC
         TJSmMaQGZoTEoGcZUCib8edHI60UA6zfh0Ccww0hUFNo/eN581y2yd+zhd2XCShqN5MD
         gXfdUgtQOq1SzQiceBbALEFyPAnoCoOe8zcwqCYX4cS3KvVF6rrZOA770g36Y4XuajH3
         3jU1rCkLgNbe5tIj8Q6dL0A07OcHM1vQMLV+rwNIXDv0n1CzjvS7G/GALHLtIis+AEpN
         Yr8LA+ASYHUapVw3SJeZuw2+fPbD8KckiatUIrA5/XdUAkGgj0gCLwZEP0PDGUYTEtrl
         a9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708555684; x=1709160484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gw5fc5I26kdjc0zlKV7SIy+DOj8voXJyqY3HQnL2RuU=;
        b=h9tX3dOlQFZqF9FuUXubJoEm7rTqCMBFn7sq1s7v8z+FiNLAuVq17vkeEeLNSCzA3U
         Ssouu+BTvSbDCinXUX7qr2eXbCd7b6Qxghjybg6xMsmWmxiGlyzP86yYyedzBiICwMFh
         1uQfyFEWzFHkTrVZWIAIHQ2wD+ZiB0YHS2wVuFjffYZcc8LMBIL9ATgs7wTX2rMJkT3L
         xctz49UGQ3qKX0PNHX1hLqYjMR5OHmVBS5PQ6BH9cTt6j8ywdl5d9qEJJmtmLvafQQCS
         tVe/wPxqneBuhd5QGGf0ZUKG+i8EnYq3BgnYUaFlDEdxUN2/mHYK2RoUx1RzxnoKAtq3
         vgCg==
X-Forwarded-Encrypted: i=1; AJvYcCXEc/2gE7XqPC/REK9NS3mb8Sc/rGBwIYwZwY8Y2BVfVEVPHrUVKGULHzkF39wwMga1O6hg6prmVbq7NoIORGwXCDpw/HEne24y
X-Gm-Message-State: AOJu0YxdRy4QfHy3VslyoprDVszvTpauQzZgpkE9AmCprnvqjBvJNJSe
	2GOvqQ2NkRGkBnq9RIZQYukTmoQ+9g6+MR8CH0GmGckRO39pn50wKJQR740TrUEf5tv1o29wpxt
	cWQ+Cl3Oh94Orf+qgzctLicWNJSJYduTkMKMS
X-Google-Smtp-Source: AGHT+IHIiztHrlPVGbWlf9kC0Qn60zcxekXTmFXaa6Zvf6bxngg4By83+kUKNWAWtpmAT3Koc+UzgsGYRi3muOBgwgE=
X-Received: by 2002:ac8:1242:0:b0:42d:dbd8:e12 with SMTP id
 g2-20020ac81242000000b0042ddbd80e12mr441467qtj.2.1708555683602; Wed, 21 Feb
 2024 14:48:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213147.489377-1-saravanak@google.com> <20240212213147.489377-4-saravanak@google.com>
 <20240214-stable-anytime-b51b898d87af@spud> <CAGETcx-tBjfaLQqmGW=ap2N5FLK_gvTzxskA6sVsr_SUEpvomA@mail.gmail.com>
 <20240215-unstirred-rearrange-d619a2524a63@spud> <CAGETcx8EBta8dUSELUJ6_ibZABnnhSYX0VEGa8s-CbHFYuskkQ@mail.gmail.com>
 <20240221-emblaze-ripeness-7ad4e41343fa@spud>
In-Reply-To: <20240221-emblaze-ripeness-7ad4e41343fa@spud>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 21 Feb 2024 14:47:26 -0800
Message-ID: <CAGETcx99Dob1D6Cr7+wN5+4aARgBdGdwEkNUjRAc6d_Ls9dqrQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: Add post-init-supplier property
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 11:34=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Tue, Feb 20, 2024 at 08:13:31PM -0800, Saravana Kannan wrote:
> > I made that fix and now I'm getting this:
> > $ make DT_CHECKER_FLAGS=3D-m dt_binding_check
> > DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/post-init-suppliers=
.yaml
> >   DTEX    Documentation/devicetree/bindings/post-init-suppliers.example=
.dts
> >   LINT    Documentation/devicetree/bindings
> >   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> > /mnt/android/linus-tree/Documentation/devicetree/bindings/post-init-sup=
pliers.yaml:
> > 'oneOf' conditional failed, one must be fixed:
> >         'unevaluatedProperties' is a required property
> >         'additionalProperties' is a required property
> >         hint: Either unevaluatedProperties or additionalProperties
> > must be present
> >         from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> > /mnt/android/linus-tree/Documentation/devicetree/bindings/tpm/ibm,vtpm.=
yaml:
> > ignoring, error in schema: properties
> > /mnt/android/linus-tree/Documentation/devicetree/bindings/post-init-sup=
pliers.yaml:
> > ignoring, error in schema:
> > /mnt/android/linus-tree/Documentation/devicetree/bindings/soc/tegra/nvi=
dia,tegra20-pmc.yaml:
> > ignoring, error in schema: allOf: 0: then: properties: pinmux
> > /mnt/android/linus-tree/Documentation/devicetree/bindings/net/lantiq,pe=
f2256.yaml:
> > ignoring, error in schema: properties: lantiq,data-rate-bps
> > /mnt/android/linus-tree/Documentation/devicetree/bindings/post-init-sup=
plier.yaml:
> > ignoring, error in schema:
> > /mnt/android/linus-tree/Documentation/devicetree/bindings/iio/pressure/=
honeywell,mprls0025pa.yaml:
> > ignoring, error in schema: properties: honeywell,pmax-pascal
> > /mnt/android/linus-tree/Documentation/devicetree/bindings/iio/pressure/=
honeywell,hsc030pa.yaml:
> > ignoring, error in schema: properties: honeywell,pmax-pascal
>
> >   DTC_CHK Documentation/devicetree/bindings/post-init-suppliers.example=
.dtb
> > Documentation/devicetree/bindings/post-init-suppliers.example.dtb:0:0:
> > /example-0/clock-controller@1000: failed to match any schema with
> > compatible: ['vendor,soc4-gcc', 'vendor,soc1-gcc']
> > Documentation/devicetree/bindings/post-init-suppliers.example.dtb:0:0:
> > /example-0/clock-controller@1000: failed to match any schema with
> > compatible: ['vendor,soc4-gcc', 'vendor,soc1-gcc']
> > Documentation/devicetree/bindings/post-init-suppliers.example.dtb:0:0:
> > /example-0/clock-controller@2000: failed to match any schema with
> > compatible: ['vendor,soc4-dispcc', 'vendor,soc1-dispcc']
> > Documentation/devicetree/bindings/post-init-suppliers.example.dtb:0:0:
> > /example-0/clock-controller@2000: failed to match any schema with
> > compatible: ['vendor,soc4-dispcc', 'vendor,soc1-dispcc']
>
> FWIW, I don't see these or the other errors you see above. You really
> need to get yourself a newer version of dt-schema, or else avoid
> working on this using whatever castrated system google provides you with!

Ok, finally found the workaround to updating these packages and the
output is a lot cleaner now.

> > But I guess the "oneOf" error is because the yaml is being treated as
> > a description of a DT node and not a schema?
>
> The oneOf is due to missing "additionalProperties: true" - As far as I
> understand you need that regardless of whether this is going into
> dt-schema or the kernel.

Ok, I added that and the errors go away. I'll send out a v3 and
hopefully Rob can pick it up.

-Saravana

