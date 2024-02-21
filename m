Return-Path: <linux-efi+bounces-605-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5027185CF3D
	for <lists+linux-efi@lfdr.de>; Wed, 21 Feb 2024 05:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A2E28219A
	for <lists+linux-efi@lfdr.de>; Wed, 21 Feb 2024 04:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E17139AC5;
	Wed, 21 Feb 2024 04:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ltAGKq+e"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283B439857
	for <linux-efi@vger.kernel.org>; Wed, 21 Feb 2024 04:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708488856; cv=none; b=TiDPXhb92Vljru6cxFzKkGDQDaEdUoYhK9qNpFZFYjBiBEcL/Pl7ypA5ZQZJNEfPUNPxhcc9NN5+yC+OTfRk1EdIEMl8u6h1ywHcm6LMlB8Y14/ASwY1nsy7dAexb6JiNcJA5M7YxPpDmcvgzdLLgmzKaPOpc9cyHWVPauwCMeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708488856; c=relaxed/simple;
	bh=iv7CH99iRhguDQ1/YjXbTn4+yMkEyHgzrQwytHVXsmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2amMVjWFG7h706cVEh5/wTiGCg735vC6lHxSaS0DG4F+umVZTdZvCP8YuTSlwp77dvljIb1t89fvN4QeOJYmZbEQdQL8bdzLRDkmcAP5da6GuRIWZv1HSMDL4SMM9I+JtJGV6jOss3MAHKcP2x4/aZ3kyiVNpojE7Et4fn4ffA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ltAGKq+e; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso4764a12.1
        for <linux-efi@vger.kernel.org>; Tue, 20 Feb 2024 20:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708488852; x=1709093652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCa6Ml6GRh+LdklHOgguZfEh9d/lY861XdAuUikozNs=;
        b=ltAGKq+e1pRtwewINOGDXpaAx3jWSDpDE5UXqojnajW6k25F/HrfoY9CnF3HSEqOX9
         O+z3CZJPoeDyeXw+uFppwgHZFJBYGsKRwLJSk4WRTPdcj0hcqF70oFozmzubx17gr6TI
         W8rKFC8WgFyfDaX/5onkLVzmuyBc5lZMNO00Y37JwHA4ZOfylYBmeJWrgx1SwSLTM5Qd
         BPecGoUf4oAWSnlA3woJQdutHgCLa3f832mP1564IXWV14VlsKpDH/xTrVqvf96kO8aa
         2PvRJEm8FDyOfdZBz1N+l2EMUWmtfKLCO25XD2OVoH/Z6kdgj2obH1CyxKwoQnA087Lk
         mjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708488852; x=1709093652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCa6Ml6GRh+LdklHOgguZfEh9d/lY861XdAuUikozNs=;
        b=uNlHBeWP0gxdsL3NnpV0/EhCirQdefZvyvyGCNwDFlel9K+rscmXLXshe/HOGUtwmG
         di13fI6LFXLFffHhWn0uSAhOU6pVrf5vDw6WbbwUL/bCbrQTMRsBKT/n1PKu4WkE6xiA
         VDjG3v4Ux8HJkOvaLkYYtyNDRTLECnU5GfXCaFV0v644PS7shFjmB3xhBtt3yCUGsw3l
         qldyo9pyv+aWPVFP1ePqF/sUbRISVNZ6D2UHwuYllTXOI6jHcN8h75AQ/IClG8FtsQ6E
         klqsM5dJxqafaGtck4AmkF8NLCYeU6wepTk90Esbt1MsDMNot28m0wNxmq+nynC+M3rm
         UKuA==
X-Forwarded-Encrypted: i=1; AJvYcCXu/xWkuIw4hfYlN0YObGsTtkSiIMCteZoRKpE3BG+dlZGf8zOJ748LG5eig5zQw8U9iQHNYu6q/9DCjxU7bg0XehddOeKrUzjZ
X-Gm-Message-State: AOJu0Yw8JXm3T3cBUhNylxS8IH57WDgq7ldc0wefX7bnk175VhOomKr8
	80n8PXu4aQVRTrNwVqiYQaLS4LZ66vSULjli385nesy0ThEgtyBXAeofdPW17Jjo45jH8UlULlo
	PicO28hzUHaqWwfc0QxCjWk6naSGg63bl3F5x
X-Google-Smtp-Source: AGHT+IEmhFJMlJUUEju8UhhM1aaUnzSKK+rUpO3avm0pyBj9JxssRH7+jbwr7oE7NQv7fjKcKV4K1nsC9iq3UoRUqVE=
X-Received: by 2002:a50:c30f:0:b0:564:55e5:6ee1 with SMTP id
 a15-20020a50c30f000000b0056455e56ee1mr107058edb.2.1708488852242; Tue, 20 Feb
 2024 20:14:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213147.489377-1-saravanak@google.com> <20240212213147.489377-4-saravanak@google.com>
 <20240214-stable-anytime-b51b898d87af@spud> <CAGETcx-tBjfaLQqmGW=ap2N5FLK_gvTzxskA6sVsr_SUEpvomA@mail.gmail.com>
 <20240215-unstirred-rearrange-d619a2524a63@spud>
In-Reply-To: <20240215-unstirred-rearrange-d619a2524a63@spud>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 20 Feb 2024 20:13:31 -0800
Message-ID: <CAGETcx8EBta8dUSELUJ6_ibZABnnhSYX0VEGa8s-CbHFYuskkQ@mail.gmail.com>
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

On Thu, Feb 15, 2024 at 4:15=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Wed, Feb 14, 2024 at 03:32:31PM -0800, Saravana Kannan wrote:
> > Hi Conon,
> >
> > On Wed, Feb 14, 2024 at 10:49=E2=80=AFAM Conor Dooley <conor@kernel.org=
> wrote:
> > >
> > > On Mon, Feb 12, 2024 at 01:31:44PM -0800, Saravana Kannan wrote:
> > > > The post-init-supplier property can be used to break a dependency c=
ycle by
> > > > marking some supplier(s) as a post device initialization supplier(s=
). This
> > > > allows an OS to do a better job at ordering initialization and
> > > > suspend/resume of the devices in a dependency cycle.
> > > >
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > >  .../bindings/post-init-supplier.yaml          | 101 ++++++++++++++=
++++
> > > >  MAINTAINERS                                   |  13 +--
> > > >  2 files changed, 108 insertions(+), 6 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/post-init-sup=
plier.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/post-init-supplier.y=
aml b/Documentation/devicetree/bindings/post-init-supplier.yaml
> > > > new file mode 100644
> > > > index 000000000000..aab75b667259
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/post-init-supplier.yaml
> > > > @@ -0,0 +1,101 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +# Copyright (c) 2020, Google LLC. All rights reserved.
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/post-init-supplier.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Post device initialization supplier
> > > > +
> > > > +maintainers:
> > > > +  - Saravana Kannan <saravanak@google.com>
> > > > +
> > > > +description: |
> > > > +  This property is used to indicate that the device(s) pointed to =
by the
> > > > +  property are not needed for the initialization of the device tha=
t lists this
> > > > +  property.
> > >
> > > > This property is meaningful only when pointing to direct suppliers
> > > > +  of a device that are pointed to by other properties in the devic=
e.
> > >
> > > I don't think this sentence makes sense, or at least it is not easy t=
o
> > > parse. It implies that it can "point to" other properties too
> >
> > I don't see how this sentence implies this.
>
> Because, to me, it reads as if you can put extra stuff in here that will
> be ignored if not "pointed to" by another property. The word
> "meaningful" is what implies that you can.
>
> > But open to suggestions on
> > how to reword it. I don't want to drop this line entirely though
> > because I'm trying to make it clear that this doesn't make a device
> > (that's not previously a supplier) into a supplier. It only down
> > grades an existing supplier to a post device initialization supplier.
>
> If you wanna keep it, I would just go for what you said in this
> response - that this property does not make devices into suppliers and
> is only to mark existing suppliers as post-init. I think that rules out
> putting other devices in there.

Sounds good.

> > > - but
> > > that's not the case. It is only valid to "point to" these suppliers.
> > > I'd drop this entirely.
> >
> > >
> > > > +
> > > > +  A device can list its suppliers in devicetree using one or more =
of the
> > > > +  standard devicetree bindings. By default, it would be safe to as=
sume the
> > > > +  supplier device can be initialized before the consumer device is=
 initialized.
> > >
> > > "it would be safe to assume" seems odd wording to me - I feel like th=
e
> > > default is stronger than "safe to assume". I'd just drop the "would b=
e
> > > safe to assume and replace with "is assumed".
> >
> > Sounds good.
> >
> > >
> > > > +
> > > > +  However, that assumption cannot be made when there are cyclic de=
pendencies
> > > > +  between devices. Since each device is a supplier (directly or in=
directly) of
> > > > +  the others in the cycle, there is no guaranteed safe order for i=
nitializing
> > > > +  the devices in a cycle. We can try to initialize them in an arbi=
trary order
> > > > +  and eventually successfully initialize all of them, but that doe=
sn't always
> > > > +  work well.
> > > > +
> > > > +  For example, say,
> > > > +  * The device tree has the following cyclic dependency X -> Y -> =
Z -> X (where
> > > > +    -> denotes "depends on").
> > > > +  * But X is not needed to fully initialize Z (X might be needed o=
nly when a
> > > > +    specific functionality is requested post initialization).
> > > > +
> > > > +  If all the other -> are mandatory initialization dependencies, t=
hen trying to
> > > > +  initialize the devices in a loop (or arbitrarily) will always ev=
entually end
> > > > +  up with the devices being initialized in the order Z, Y and X.
> > > > +
> > > > +  However, if Y is an optional supplier for X (where X provides li=
mited
> > > > +  functionality when Y is not initialized and providing its servic=
es), then
> > > > +  trying to initialize the devices in a loop (or arbitrarily) coul=
d end up with
> > > > +  the devices being initialized in the following order:
> > > > +
> > > > +  * Z, Y and X - All devices provide full functionality
> > > > +  * Z, X and Y - X provides partial functionality
> > > > +  * X, Z and Y - X provides partial functionality
> > > > +
> > > > +  However, we always want to initialize the devices in the order Z=
, Y and X
> > > > +  since that provides the full functionality without interruptions=
.
> > > > +
> > > > +  One alternate option that might be suggested is to have the driv=
er for X
> > > > +  notice that Y became available at a later point and adjust the f=
unctionality
> > > > +  it provides. However, other userspace applications could have st=
arted using X
> > > > +  with the limited functionality before Y was available and it mig=
ht not be
> > > > +  possible to transparently transition X or the users of X to full
> > > > +  functionality while X is in use.
> > > > +
> > > > +  Similarly, when it comes to suspend (resume) ordering, it's uncl=
ear which
> > > > +  device in a dependency cycle needs to be suspended/resumed first=
 and trying
> > > > +  arbitrary orders can result in system crashes or instability.
> > > > +
> > > > +  Explicitly calling out which link in a cycle needs to be broken =
when
> > > > +  determining the order, simplifies things a lot, improves efficie=
ncy, makes
> > > > +  the behavior more deterministic and maximizes the functionality =
that can be
> > > > +  provided without interruption.
> > > > +
> > > > +  This property is used to provide this additional information bet=
ween devices
> > > > +  in a cycle by telling which supplier(s) is not needed for initia=
lizing the
> > > > +  device that lists this property.
> > > > +
> > > > +  In the example above, Z would list X as a post-init-supplier and=
 the
> > > > +  initialization dependency would become X -> Y -> Z -/-> X. So th=
e best order
> > > > +  to initialize them become clear: Z, Y and then X.
> > >
> > > Otherwise, I think this is a great description, describing the use ca=
se
> > > well :)
> >
> > Thanks! I always spend more time writing documentation and commit text
> > than the time I spend writing code.
> >
> > >
> > > > +
> > > > +select: true
> > > > +properties:
> > > > +  post-init-supplier:
> >
> > [Merging your other email here]
> >
> > > Also, this should likely be pluralised, to match "clocks" "resets"
> > > "interrupts" etc.
> >
> > Good point. Done.
> >
> > > > +    # One or more suppliers can be marked as post initialization s=
upplier
> > > > +    description:
> > > > +      List of phandles to suppliers that are not needed for initia=
lizing or
> > > > +      resuming this device.
> > > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > +      items:
> > > > +        maxItems: 1
> > >
> > > Rob's bot rightfully complains here about invalid syntax.
> >
> > I added these two lines based on Rob's feedback. Is the indentation
> > that's wrong?
>
> Aye, both items: and maxItems: need to lose a level of indent. That
> said, its not actually restricting anything. I fixed it up locally and
> you can put as many elements as you like into each phandle and it does
> not care. Maybe Rob can tell what is going wrong there..

I made that fix and now I'm getting this:
$ make DT_CHECKER_FLAGS=3D-m dt_binding_check
DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/post-init-suppliers.yam=
l
  DTEX    Documentation/devicetree/bindings/post-init-suppliers.example.dts
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
/mnt/android/linus-tree/Documentation/devicetree/bindings/post-init-supplie=
rs.yaml:
'oneOf' conditional failed, one must be fixed:
        'unevaluatedProperties' is a required property
        'additionalProperties' is a required property
        hint: Either unevaluatedProperties or additionalProperties
must be present
        from schema $id: http://devicetree.org/meta-schemas/core.yaml#
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
/mnt/android/linus-tree/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml=
:
ignoring, error in schema: properties
/mnt/android/linus-tree/Documentation/devicetree/bindings/post-init-supplie=
rs.yaml:
ignoring, error in schema:
/mnt/android/linus-tree/Documentation/devicetree/bindings/soc/tegra/nvidia,=
tegra20-pmc.yaml:
ignoring, error in schema: allOf: 0: then: properties: pinmux
/mnt/android/linus-tree/Documentation/devicetree/bindings/net/lantiq,pef225=
6.yaml:
ignoring, error in schema: properties: lantiq,data-rate-bps
/mnt/android/linus-tree/Documentation/devicetree/bindings/post-init-supplie=
r.yaml:
ignoring, error in schema:
/mnt/android/linus-tree/Documentation/devicetree/bindings/iio/pressure/hone=
ywell,mprls0025pa.yaml:
ignoring, error in schema: properties: honeywell,pmax-pascal
/mnt/android/linus-tree/Documentation/devicetree/bindings/iio/pressure/hone=
ywell,hsc030pa.yaml:
ignoring, error in schema: properties: honeywell,pmax-pascal
  DTC_CHK Documentation/devicetree/bindings/post-init-suppliers.example.dtb
Documentation/devicetree/bindings/post-init-suppliers.example.dtb:0:0:
/example-0/clock-controller@1000: failed to match any schema with
compatible: ['vendor,soc4-gcc', 'vendor,soc1-gcc']
Documentation/devicetree/bindings/post-init-suppliers.example.dtb:0:0:
/example-0/clock-controller@1000: failed to match any schema with
compatible: ['vendor,soc4-gcc', 'vendor,soc1-gcc']
Documentation/devicetree/bindings/post-init-suppliers.example.dtb:0:0:
/example-0/clock-controller@2000: failed to match any schema with
compatible: ['vendor,soc4-dispcc', 'vendor,soc1-dispcc']
Documentation/devicetree/bindings/post-init-suppliers.example.dtb:0:0:
/example-0/clock-controller@2000: failed to match any schema with
compatible: ['vendor,soc4-dispcc', 'vendor,soc1-dispcc']

But I guess the "oneOf" error is because the yaml is being treated as
a description of a DT node and not a schema?

Rob,

Can you let me know how to move ahead with this? I'll do the fixes
that Conor suggested in v3.

-Saravana

>
> >
> > Yeah, I'm trying to run the dts checker, but I haven't be able to get
> > it to work on my end. See my email to Rob on the v1 series about this.
> >
> > $ make DT_CHECKER_FLAGS=3D-m dt_binding_check
> >
> > The best I could get out of it is a bunch of error reports on other
> > files and then:
> > ...
> > <snip>/Documentation/devicetree/bindings/post-init-suppliers.yaml:
> > ignoring, error parsing file
> > ...
>
> Yup, that is about right, although you snipped out the actual complaint.
>
> >
> > I also tried to use DT_SCHEMA_FILES so I can only test this one file,
> > but that wasn't working either:
> >
> > $ make DT_CHECKER_FLAGS=3D-m dt_binding_check
> > DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/post-init-suppliers=
.yaml
> > or
> > $ make DT_CHECKER_FLAGS=3D-m dt_binding_check DT_SCHEMA_FILES=3D<path t=
o
> > the .patch file>
> >
> > Results in this error early on in the output:
> > ...
> > usage: yamllint [-h] [-] [-c CONFIG_FILE | -d CONFIG_DATA]
> > [--list-files] [-f {parsable,standard,colored,github,auto}] [-s]
> > [--no-warnings] [-v] [FILE_OR_DIR ...]
> > yamllint: error: one of the arguments FILE_OR_DIR - is required
> > ...
> > /mnt/android/linus-tree/Documentation/devicetree/bindings/post-init-sup=
pliers.yaml:
> > ignoring, error parsing file
> > ...
>
> That is part of the actual complaint:
>
> make dt_binding_check W=3D1 -j 30 DT_SCHEMA_FILES=3Dpost-init-supplier.ya=
ml
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/post-init-supplier.example.dt=
s
> Documentation/devicetree/bindings/post-init-supplier.yaml:84:12: mapping =
values are not allowed here
> make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentatio=
n/devicetree/bindings/post-init-supplier.example.dts] Error 1
> make[2]: *** Deleting file 'Documentation/devicetree/bindings/post-init-s=
upplier.example.dts'
> make[2]: *** Waiting for unfinished jobs....
> ./Documentation/devicetree/bindings/post-init-supplier.yaml:84:12: [error=
] syntax error: mapping values are not allowed here (syntax)
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> ./Documentation/devicetree/bindings/post-init-supplier.yaml:84:12: mappin=
g values are not allowed here
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> /stuff/linux-dt/Documentation/devicetree/bindings/post-init-supplier.yaml=
: ignoring, error parsing file
> make[1]: *** [/stuff/linux-dt/Makefile:1432: dt_binding_check] Error 2
> make: *** [Makefile:240: __sub-make] Error 2

