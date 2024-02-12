Return-Path: <linux-efi+bounces-507-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96899851F33
	for <lists+linux-efi@lfdr.de>; Mon, 12 Feb 2024 22:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D24C284C6B
	for <lists+linux-efi@lfdr.de>; Mon, 12 Feb 2024 21:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A374C624;
	Mon, 12 Feb 2024 21:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r8L2f28v"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C874C615
	for <linux-efi@vger.kernel.org>; Mon, 12 Feb 2024 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772124; cv=none; b=ilrAlsj0tpE5FSrrUk2BUBIBhmCHg5HDSxrdaSa7n8pGXdAnUtAzZvgBI+dJZmgnBS8jDRIk41PgmOoU/+PudAcJjs7givaL4Tl9cayB7hQ/0elDjEQ7Sd8GGi/w7WoxGAd1QPGv6amP+gL8SKs6mrdyFcvkv3MZa5tbLe84NRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772124; c=relaxed/simple;
	bh=cT6oEXxc39vrH0YgJRtkQAV0D4LcChlx3yJhcWWEjVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9Ap7RZsUho+0yEQ6KVZ5T9AFiHS3nqAoP7eyRiY5o4bnUc3qwThhGt6N7GsaeVGdCpk9i94XNo5SU0FinUK/OdeCPQWqiEjA4eHwRrOAot2D0SPvQzvkNJUjOJfac3AAdIjVVtHasaJVU5Twfi6GXMbMK+vtRr+/2Qz/BU20tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r8L2f28v; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42c70247923so4701cf.1
        for <linux-efi@vger.kernel.org>; Mon, 12 Feb 2024 13:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707772119; x=1708376919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+d9JGQ7QCBLiQWxTJtAp8Y26oWjCdolLMdTv/a9cv8=;
        b=r8L2f28vmdmC+afXY3kzvpCHql+6fSIoy6kZ7N0L/1Z7R+WNL7XGAXjqLkrwLvSgFc
         MyF/7HKEf9D5yw50XeJI7+B6JlLBD4DeV0493ayCOuIZW0oK+AtqHIsXvxP8zEpZb5Vi
         Za+mIkQT6KIeTkvAIu2iL4ejia1GJaJuL8s4j+t4/K+0zl1XtgsF/xqiM4bSjfpPleGS
         1x9CS2Zp+OfB33nNi1j04d2jblTOqgJ5J43Ixl5Uq8f62N733hIuSi8xtvsFt15bWyc3
         X10OMn/8jB40v3OMuGJ9eoF7araGA3Q8nfqX8N5AWc090TupfSuLIer/swTP43W6brCw
         PRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707772119; x=1708376919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+d9JGQ7QCBLiQWxTJtAp8Y26oWjCdolLMdTv/a9cv8=;
        b=h0dxgC9xwa4ejcJiZ3Dv4YbkaSWN1jyPJ9KoAeJDah+onJzphq10gUu4tB9Icl0bRD
         phxqOzrms0f0rF7FAU5qRSuJAhyuMBGfE3zqjsdgQrsOXgxCV8BRn+tZGbZCLVpq89jq
         /La4GtCIV2ILHSVVCwOu4zTcr3FkHcaNf/80QZC3n3KBjrB9YG9NofaoixhaJMywWfAy
         H5eBO6ttLLPmvQbY+wkedTZNKtev/qHVGSizS946Hybcia3AqvaPgENZPcs7p+BSZXIV
         At8z/phRY27aJp4yvi3uVLmqNw4B5VHI7bhnTV7wsC91lk5/4e3W+mhNUiyNvT+mvYji
         88dg==
X-Forwarded-Encrypted: i=1; AJvYcCVDPrz9KGBfZ9iXBkwvKXXbWHxem/Lxw7ulUYUDfiMSpgbAiP12GHCTMPNXlMoxLRiKqK8UUrAVEFRneUcRu1KQoa3kuyPQkAgr
X-Gm-Message-State: AOJu0YzG0iOVRpDRXDvctN23KOUxm5uML52CWf4mMEUJ6Ya3j766Vhnk
	UpiqyjBY21Oz2NjXR6L9wAnwR9j7D9VeVInq+jwUKOUCmVdBqM2PQUAzGzO5nY3N8GvwjhCX2TG
	/6DQprtAMt6xYWvOwS/bnIAfB7cq1PRtzEK8l
X-Google-Smtp-Source: AGHT+IEDqmoTtT2agh02uJiNKeZfP9bWjW02lWNGSEM6It4rrTXIHzftcneItrx4H7q3pIKgvKfKACqaEEyykLLBu0g=
X-Received: by 2002:ac8:6e8d:0:b0:42c:5c91:b93c with SMTP id
 c13-20020ac86e8d000000b0042c5c91b93cmr7185qtv.27.1707772119457; Mon, 12 Feb
 2024 13:08:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210030549.4048795-1-saravanak@google.com>
 <20240210030549.4048795-4-saravanak@google.com> <CAL_Jsq+tMK6myLtvD2EYEE2juev+wMvWoVMnYpT8JPy2eD9hKA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+tMK6myLtvD2EYEE2juev+wMvWoVMnYpT8JPy2eD9hKA@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 12 Feb 2024 13:08:00 -0800
Message-ID: <CAGETcx-g6MXk0DP8pNwiGfjr4amdc0Mha3Uk9Kx74xaqxbUHOg@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] dt-bindings: Add post-init-supplier property
To: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 3:26=E2=80=AFAM Rob Herring <robh+dt@kernel.org> wr=
ote:
>
> On Sat, Feb 10, 2024 at 3:06=E2=80=AFAM Saravana Kannan <saravanak@google=
.com> wrote:
> >
> > The post-init-supplier property can be used to break a dependency cycle=
 by
> > marking some supplier(s) as a post device initialization supplier(s). T=
his
> > allows the kernel to do a better job at ordering initialization and
>
> s/the kernel/an OS/
>
> > suspend/resume of the devices in a dependency cycle.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  .../bindings/post-init-supplier.yaml          | 99 +++++++++++++++++++
>
> This should probably go into dtschema instead, but fine here now for revi=
ewing.

How do I submit it for dtschema?

> We have to consider if this property should be automatically allowed
> on any node or nodes with specific suppliers, or if it should be
> explicit for users. The former needs tool support. I'm leaning towards
> the latter as I want to know when this is needed.

I think I understand your question. This property can be relevant for
any device -- it really depends on the device's consumers and
suppliers and if they form a cycle. Ideally, we can check if a device
is in a cycle and then allow it only for those, but that's going to be
too complicated I think. So, I think this should be allowed for any
device.

Since this property is defined as a "post-init-supplier" and only
applies to an existing direct supplier, there's not a lot of room for
misuse. Actually if you can add a check "are all the phandles listed
in this property also present in one of the other properties in this
device node", that should be sufficient.

I'll also edit the documentation to make it clear it's meaningful only
for an existing supplier.

>
> >  MAINTAINERS                                   |  3 +-
> >  2 files changed, 101 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/post-init-supplie=
r.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/post-init-supplier.yaml =
b/Documentation/devicetree/bindings/post-init-supplier.yaml
> > new file mode 100644
> > index 000000000000..cf9071ecd06e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/post-init-supplier.yaml
> > @@ -0,0 +1,99 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2018 Linaro Ltd.
>
> ?

Oops... didn't edit out all the lines in the example.

I'll address all your other comments in the next patch.

Btw, this is the command I used to validate this file (before I sent
v1), but it didn't spit out anything meaningful that I could
understand:

make dt_binding_check DT_CHECKER_FLAGS=3D-m
DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/trivial-devices.yaml

Is that the right way to run it? I'm using yamllint 1.32. So it's not
terribly old either (can't install anything newer).

-Saravana

>
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/post-init-supplier.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Post device initialization supplier
> > +
> > +maintainers:
> > +  - Saravana Kannan <saravanak@google.com>
> > +
> > +description: |
> > +  This property is used to indicate that the device(s) pointed to by t=
he
> > +  property are not needed for the initialization of the device that li=
sts this
> > +  property.
> > +
> > +  A device can list its suppliers in devicetree using one or more of t=
he
> > +  standard devicetree bindings. By default, it would be safe to assume=
 the
> > +  supplier device can be initialized before the consumer device is ini=
tialized.
> > +
> > +  However, that assumption cannot be made when there are cyclic depend=
ecies
>
> typo
>
> > +  between devices. Since each device is a supplier (directly or indire=
ctly) of
> > +  the others in the cycle, there is no guaranteed safe order for inita=
lizing
>
> typo
>
> > +  the devices in a cycle. We can try to initialize them in an arbitrar=
y order
> > +  and eventually successfully initialize all of them, but that doesn't=
 always
> > +  work well.
> > +
> > +  For example, say,
> > +  * The device tree has the following cyclic dependency X -> Y -> Z ->=
 X (where
> > +    -> denotes "depends on").
> > +  * But X is not needed to fully initialize Z (X might be needed only =
when a
> > +    specific functionality if requested post initialization).
> > +
> > +  If all the other -> are mandatory initialization dependencies, then =
trying to
> > +  initialize the devices in a loop (or arbitrarily) will always eventu=
ally end
> > +  up with the devices being initialized in the order Z, Y and X.
> > +
> > +  However, if Y is an optional supplier for X (where X provides limite=
d
> > +  functionality when Y is not initialized and providing its services),=
 then
> > +  trying to initialize the devices in a loop (or arbitrarily) could en=
d up with
> > +  the devices being initialized in the following order:
> > +
> > +  * Z, Y and X - All devices provide full functionality
> > +  * Z, X and Y - X provides partial functionality
> > +  * X, Z and Y - X provides partial functionality
> > +
> > +  However, we always want to initialize the devices in the order Z, Y =
and X
> > +  since that provides the full functionality without interruptions.
> > +
> > +  One alternate option that might be suggested is to have the driver f=
or X
> > +  notice that Y became available at a later point and adjust the funct=
ionality
> > +  it provides. However, other userspace applications could have starte=
d using X
> > +  with the limited functionality before Y was available and it might n=
ot be
> > +  possible to transparently transition X or the users of X to full
> > +  functionality while X is in use.
> > +
> > +  Similarly, when it comes to suspend (resume) ordering, it's unclear =
which
> > +  device in a dependency cycle needs to be suspended/resumed first and=
 trying
> > +  arbitrary orders can result in system crashes or instability.
> > +
> > +  Explicitly calling out which link in a cycle needs to be broken when
> > +  determining the order, simplifies things a lot, improves efficiency,=
 makes
> > +  the behavior more deterministic and maximizes the functionality that=
 can be
> > +  provided without interruption.
> > +
> > +  This property is used to provide this additional information between=
 devices
> > +  in a cycle by telling which supplier(s) is not needed for initializi=
ng the
> > +  device that lists this property.
> > +
> > +  In the example above, Z would list X as a post-init-supplier and the
> > +  initialization dependency would become X -> Y -> Z -/-> X. So the be=
st order
> > +  to initialize them become clear: Z, Y and then X.
> > +
>
> select: true
>
> Otherwise, this is never applied.
>
> > +properties:
> > +  # A dictionary of DT properties for this binding schema
>
> Drop
>
> > +  post-init-supplier:
> > +    # One or more suppliers can be marked as post initialization suppl=
ier
> > +    minItems: 1
>
> That's the default.
>
> > +    description:
> > +      List of phandles to suppliers that are not needed for initializi=
ng or
> > +      resuming this device.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
>
> Should be phandle-array plus:
>
> items:
>   maxItems: 1
>
> (as each entry is a single phandle)
>
> > +
> > +examples:
> > +  - |
> > +    gcc: general-clock-controller@1000 {
>
> clock-controller@1000
>
> > +        compatible =3D "vendor,soc4-gcc", "vendor,soc1-gcc";
> > +        reg =3D <0x1000 0x80>;> +        clocks =3D <&dispcc 0x1>
> > +        #clock-cells =3D <1>;
> > +        post-init-supplier =3D <&dispcc>;
> > +    };
> > +    dispcc: display-clock-controller@2000 {
>
> clock-controller@2000
>
> > +        compatible =3D "vendor,soc4-dispcc", "vendor,soc1-dispcc";
> > +        reg =3D <0x2000 0x80>;
> > +        clocks =3D <&gcc 0xdd>
> > +        #clock-cells =3D <1>;
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3dfe7ea25320..40fd498543a5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6055,10 +6055,11 @@ S:      Maintained
> >  F:     drivers/base/devcoredump.c
> >  F:     include/linux/devcoredump.h
> >
> > -DEVICE DEPENDENCY HELPER SCRIPT
> > +FIRMWARE DEVICE LINK (fw_devlink)
> >  M:     Saravana Kannan <saravanak@google.com>
> >  L:     linux-kernel@vger.kernel.org
> >  S:     Maintained
> > +F:     Documentation/devicetree/bindings/post-init-supplier.yaml
> >  F:     scripts/dev-needs.sh
> >
> >  DEVICE DIRECT ACCESS (DAX)
> > --
> > 2.43.0.687.g38aa6559b0-goog
> >

