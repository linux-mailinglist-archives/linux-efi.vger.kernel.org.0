Return-Path: <linux-efi+bounces-503-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB3A850423
	for <lists+linux-efi@lfdr.de>; Sat, 10 Feb 2024 12:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6303E1C223E1
	for <lists+linux-efi@lfdr.de>; Sat, 10 Feb 2024 11:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02C23CF44;
	Sat, 10 Feb 2024 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uS3WTuqW"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6302D3C099;
	Sat, 10 Feb 2024 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707564387; cv=none; b=KEmkINylO/VN+rEJwzJnwfb5iSUYT1+8CK0Yy8QtZzywXa4PFSeRW1i+6u1SnD+N3wi48YTL3wIT7hK04+KviWqdbvdEMj+7VBscBh7SgPAspWsbuMZL0wS5/NjP4/8vp2oFMBxMe579SB3WhpX8eEWfwb1zrQ95hu49ZIapDHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707564387; c=relaxed/simple;
	bh=L0ci31G0jYzl6VBiXaBLl3DHMQtouFJCjuDEsEbmM1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZchU8M1j21yJInIKqNDEGWgwR+Inktm8k6WseqM88hjd6MXU7WVjdTSqJKJDZn5b0QXrtbpKk5dlEbxYmtDqrZOAMhBV556P2Z+jOF0K5vjwB9Xt40+MjuFvR4aGmKy98RA7Xa2lMP9tCc3EAvnj8oaUIDv4PUrNwOAoY6fMkRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uS3WTuqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D428DC43390;
	Sat, 10 Feb 2024 11:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707564386;
	bh=L0ci31G0jYzl6VBiXaBLl3DHMQtouFJCjuDEsEbmM1I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uS3WTuqWK5m//0XlZlfvv4zylVUZ6S1WBcNbg5UoupukNn7eZbc2MMVolo7OqWUpl
	 lMdcqn9VeaW4OqVX9JHgcPcc0E8UvhSukGP/eM5Wk78n1x9gCwj3785IwZhrHFAJcd
	 cEPGa2K+WqwxWmzsMBhdoabMcGMLtlHQPf/uqsCxTq5C1FlDBA43WXzzAA46RtBXRr
	 csMkRCZXqW+rDPhoFwiqFoLe7EFau/A76vVSvfSYpT8f3aVWbtLn7IKaF7UTdGXDd0
	 aAwYQFc8t6FnBzwlfV5+P/zQSq88iLWPS1Vus1t9O0ic2HoWYzWPXVRPPYPHn5hVgd
	 9QtYeMTEFMZqw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d0cdbd67f0so22921821fa.3;
        Sat, 10 Feb 2024 03:26:26 -0800 (PST)
X-Gm-Message-State: AOJu0YzzhXhCSBwgmoNB2tBFMzEYkUCxPuqAATgGAfagxORAcYSyt0yR
	Ms1en/TkTaEv/kJkH8wXHRIr0ijNb1DEwMgGOkjOtj2ap0jYBfiGCyVE3e525/7i1HpwFluLrGH
	teAUIWFFKQ+fdB+gEspZdhkUqmA==
X-Google-Smtp-Source: AGHT+IGm5CAQFu2k6EUAvZ+8eqM1TlsDaGcpTUrthNslat/7K4fnyWnRVvu9hHQ3c+CErN8WYacAoVSbXGiF8UUqelU=
X-Received: by 2002:a2e:3806:0:b0:2d0:a71f:5eab with SMTP id
 f6-20020a2e3806000000b002d0a71f5eabmr1287112lja.23.1707564384958; Sat, 10 Feb
 2024 03:26:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210030549.4048795-1-saravanak@google.com> <20240210030549.4048795-4-saravanak@google.com>
In-Reply-To: <20240210030549.4048795-4-saravanak@google.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Sat, 10 Feb 2024 11:26:13 +0000
X-Gmail-Original-Message-ID: <CAL_Jsq+tMK6myLtvD2EYEE2juev+wMvWoVMnYpT8JPy2eD9hKA@mail.gmail.com>
Message-ID: <CAL_Jsq+tMK6myLtvD2EYEE2juev+wMvWoVMnYpT8JPy2eD9hKA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] dt-bindings: Add post-init-supplier property
To: Saravana Kannan <saravanak@google.com>
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

On Sat, Feb 10, 2024 at 3:06=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> The post-init-supplier property can be used to break a dependency cycle b=
y
> marking some supplier(s) as a post device initialization supplier(s). Thi=
s
> allows the kernel to do a better job at ordering initialization and

s/the kernel/an OS/

> suspend/resume of the devices in a dependency cycle.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  .../bindings/post-init-supplier.yaml          | 99 +++++++++++++++++++

This should probably go into dtschema instead, but fine here now for review=
ing.

We have to consider if this property should be automatically allowed
on any node or nodes with specific suppliers, or if it should be
explicit for users. The former needs tool support. I'm leaning towards
the latter as I want to know when this is needed.

>  MAINTAINERS                                   |  3 +-
>  2 files changed, 101 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/post-init-supplier.=
yaml
>
> diff --git a/Documentation/devicetree/bindings/post-init-supplier.yaml b/=
Documentation/devicetree/bindings/post-init-supplier.yaml
> new file mode 100644
> index 000000000000..cf9071ecd06e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/post-init-supplier.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2018 Linaro Ltd.

?

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/post-init-supplier.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Post device initialization supplier
> +
> +maintainers:
> +  - Saravana Kannan <saravanak@google.com>
> +
> +description: |
> +  This property is used to indicate that the device(s) pointed to by the
> +  property are not needed for the initialization of the device that list=
s this
> +  property.
> +
> +  A device can list its suppliers in devicetree using one or more of the
> +  standard devicetree bindings. By default, it would be safe to assume t=
he
> +  supplier device can be initialized before the consumer device is initi=
alized.
> +
> +  However, that assumption cannot be made when there are cyclic dependec=
ies

typo

> +  between devices. Since each device is a supplier (directly or indirect=
ly) of
> +  the others in the cycle, there is no guaranteed safe order for initali=
zing

typo

> +  the devices in a cycle. We can try to initialize them in an arbitrary =
order
> +  and eventually successfully initialize all of them, but that doesn't a=
lways
> +  work well.
> +
> +  For example, say,
> +  * The device tree has the following cyclic dependency X -> Y -> Z -> X=
 (where
> +    -> denotes "depends on").
> +  * But X is not needed to fully initialize Z (X might be needed only wh=
en a
> +    specific functionality if requested post initialization).
> +
> +  If all the other -> are mandatory initialization dependencies, then tr=
ying to
> +  initialize the devices in a loop (or arbitrarily) will always eventual=
ly end
> +  up with the devices being initialized in the order Z, Y and X.
> +
> +  However, if Y is an optional supplier for X (where X provides limited
> +  functionality when Y is not initialized and providing its services), t=
hen
> +  trying to initialize the devices in a loop (or arbitrarily) could end =
up with
> +  the devices being initialized in the following order:
> +
> +  * Z, Y and X - All devices provide full functionality
> +  * Z, X and Y - X provides partial functionality
> +  * X, Z and Y - X provides partial functionality
> +
> +  However, we always want to initialize the devices in the order Z, Y an=
d X
> +  since that provides the full functionality without interruptions.
> +
> +  One alternate option that might be suggested is to have the driver for=
 X
> +  notice that Y became available at a later point and adjust the functio=
nality
> +  it provides. However, other userspace applications could have started =
using X
> +  with the limited functionality before Y was available and it might not=
 be
> +  possible to transparently transition X or the users of X to full
> +  functionality while X is in use.
> +
> +  Similarly, when it comes to suspend (resume) ordering, it's unclear wh=
ich
> +  device in a dependency cycle needs to be suspended/resumed first and t=
rying
> +  arbitrary orders can result in system crashes or instability.
> +
> +  Explicitly calling out which link in a cycle needs to be broken when
> +  determining the order, simplifies things a lot, improves efficiency, m=
akes
> +  the behavior more deterministic and maximizes the functionality that c=
an be
> +  provided without interruption.
> +
> +  This property is used to provide this additional information between d=
evices
> +  in a cycle by telling which supplier(s) is not needed for initializing=
 the
> +  device that lists this property.
> +
> +  In the example above, Z would list X as a post-init-supplier and the
> +  initialization dependency would become X -> Y -> Z -/-> X. So the best=
 order
> +  to initialize them become clear: Z, Y and then X.
> +

select: true

Otherwise, this is never applied.

> +properties:
> +  # A dictionary of DT properties for this binding schema

Drop

> +  post-init-supplier:
> +    # One or more suppliers can be marked as post initialization supplie=
r
> +    minItems: 1

That's the default.

> +    description:
> +      List of phandles to suppliers that are not needed for initializing=
 or
> +      resuming this device.
> +    $ref: /schemas/types.yaml#/definitions/phandle

Should be phandle-array plus:

items:
  maxItems: 1

(as each entry is a single phandle)

> +
> +examples:
> +  - |
> +    gcc: general-clock-controller@1000 {

clock-controller@1000

> +        compatible =3D "vendor,soc4-gcc", "vendor,soc1-gcc";
> +        reg =3D <0x1000 0x80>;> +        clocks =3D <&dispcc 0x1>
> +        #clock-cells =3D <1>;
> +        post-init-supplier =3D <&dispcc>;
> +    };
> +    dispcc: display-clock-controller@2000 {

clock-controller@2000

> +        compatible =3D "vendor,soc4-dispcc", "vendor,soc1-dispcc";
> +        reg =3D <0x2000 0x80>;
> +        clocks =3D <&gcc 0xdd>
> +        #clock-cells =3D <1>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3dfe7ea25320..40fd498543a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6055,10 +6055,11 @@ S:      Maintained
>  F:     drivers/base/devcoredump.c
>  F:     include/linux/devcoredump.h
>
> -DEVICE DEPENDENCY HELPER SCRIPT
> +FIRMWARE DEVICE LINK (fw_devlink)
>  M:     Saravana Kannan <saravanak@google.com>
>  L:     linux-kernel@vger.kernel.org
>  S:     Maintained
> +F:     Documentation/devicetree/bindings/post-init-supplier.yaml
>  F:     scripts/dev-needs.sh
>
>  DEVICE DIRECT ACCESS (DAX)
> --
> 2.43.0.687.g38aa6559b0-goog
>

