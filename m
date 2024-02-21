Return-Path: <linux-efi+bounces-604-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C04785CF37
	for <lists+linux-efi@lfdr.de>; Wed, 21 Feb 2024 05:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59CD1F25494
	for <lists+linux-efi@lfdr.de>; Wed, 21 Feb 2024 04:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1681138FA3;
	Wed, 21 Feb 2024 04:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xMyMoqWJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C14E38DE6
	for <linux-efi@vger.kernel.org>; Wed, 21 Feb 2024 04:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708488513; cv=none; b=lqrsPVOityh42Hwlcuws3ayNk9DhIzjURjcmIIquDAFoqsmLKp4Z5D3R0wswbVo7wjFVv3goFhplqbyr+q1t12gXt35hOvWvrppo80ZWZh17/UVP7Imr81kkU72czBmcAAVcSubaIgIwYq9KUjdiD4CoxbjviUS/QfNXAlPUwwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708488513; c=relaxed/simple;
	bh=VMnZZMlvZpAbCe/9PN4y8l6fqn6fzCdYpCLaJwhENmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xi4PxULwqy6zBDaNl5zH7vVkCSHJxJZH3uSzM7ap+Th9ErP8K1+zIQtyjQleBBebcKF1n2J1GGZmcdOE2mAFat7y6osQhziEfFxwi2ZGUTw/BspL/Vo5wHfP571X4ChYwLy1KRG77zt7bKC5T2sKkDc40okMunoTAnqyaamq/CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xMyMoqWJ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso4696a12.1
        for <linux-efi@vger.kernel.org>; Tue, 20 Feb 2024 20:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708488509; x=1709093309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vYLUdRHnLOuE5GlvVy5mmDzCcmYulWt5UKno2mI/Ts=;
        b=xMyMoqWJWUh+y/Z7mD1swhWNCdspx5wwLL/H6thBwHhdCxoeo5NL9HnfVoYpll3wQR
         FBi23f/6ITJisMLOy/rh/cmGA9ExQLxygiZQwu5Tksbwy264juz64oMyLem1Yts9EJgo
         lMg+2fsgnmtK+tRuLpxdngmnJQpEvV6bj/aIdqFQPqnV8yai+zFjK34GJqkSKLsRHbtc
         hE+ZWHamJbUevirArV2knhqefRIezkM8M9v1IBwVydOVRRRkXmoEQWGFoLJylxpen5/N
         F1PnQbBWEyaPyT2QuCkLfOUAyC3Nr39tCg0gcjiXzOGC/ZX2QOsIql3Qwb894CkvIbvV
         1zmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708488509; x=1709093309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vYLUdRHnLOuE5GlvVy5mmDzCcmYulWt5UKno2mI/Ts=;
        b=aynMKqQIQB68gMtA+UlUUmyozzEbkxr2jQ/O8oYzW9c/9Z62lH0x+y82QKfe2x0Buy
         syRcmStu4vAJVTwVYbiO4SiMAiN7bz4ekwABsjUcumZvYYzlxqLKBF8BfbSTl5EH3Agq
         Mei1C3gvImzcUrVhPjbvdjTPHmwx1kFjXzuFgeefNNZuUSdN8fHVnG6ADkNckygYnQ0/
         2NIZGlI+UuTJ0m9ZhzoOFxoe9AsiwbEQPi8Dd/vlk2skBcUUJNGF+jYuzq3YC1drvYL8
         9Z2RmtZda8w2FHSNM4SYLObuznfC68ig92QgHZbggHYGoZDTbYkC8e31naJy/bLmkgoj
         MAJw==
X-Forwarded-Encrypted: i=1; AJvYcCWNSQc+Jx7TEQvVRnKxeIskaQ7q5Nxf3BUP3TSupGC44ZHrMLOxLXJZJb/hIsGvtLath9iHRrcIO7fU3VJsx3lJMrBMcoXUk+a6
X-Gm-Message-State: AOJu0Yz+TXTm76Whqb9ezenKFhEHAbwHYcPEFYVl75H7BEerxh2Qzp1F
	9/Zv8bTPw7WOxRuGlFesSEDfZzREA2spJRj60/10pOaKRaITDSTNcgH2XazdlTsGV1V3uLgUKtU
	LQwCd0QW5I48iN5BW77MfPlxrG0pIaStg1RFb
X-Google-Smtp-Source: AGHT+IHmgqd6Xu5JQrE9v4Rhsl5MKM0/pejNdb3HvU+7d2flqEB0yhf6jyU2v+sB5FmKxqZFYTO435nbWJ8DHnQHhOM=
X-Received: by 2002:a50:d5d9:0:b0:563:f48f:a5bc with SMTP id
 g25-20020a50d5d9000000b00563f48fa5bcmr47442edj.5.1708488509288; Tue, 20 Feb
 2024 20:08:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213147.489377-1-saravanak@google.com> <20240212213147.489377-4-saravanak@google.com>
 <20240214-stable-anytime-b51b898d87af@spud> <CAGETcx-tBjfaLQqmGW=ap2N5FLK_gvTzxskA6sVsr_SUEpvomA@mail.gmail.com>
 <b7fcb71a-e3bf-4f50-89d6-caff9f3303dc@linaro.org>
In-Reply-To: <b7fcb71a-e3bf-4f50-89d6-caff9f3303dc@linaro.org>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 20 Feb 2024 20:07:48 -0800
Message-ID: <CAGETcx8XBj=vh_e3vyXuj8oQYA3UC4uy9h9K2OmwBxZ2G_ms9Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: Add post-init-supplier property
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
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

On Sat, Feb 17, 2024 at 2:27=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/02/2024 00:32, Saravana Kannan wrote:
> >
> > Good point. Done.
> >
> >>> +    # One or more suppliers can be marked as post initialization sup=
plier
> >>> +    description:
> >>> +      List of phandles to suppliers that are not needed for initiali=
zing or
> >>> +      resuming this device.
> >>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >>> +      items:
> >>> +        maxItems: 1
> >>
> >> Rob's bot rightfully complains here about invalid syntax.
> >
> > I added these two lines based on Rob's feedback. Is the indentation
> > that's wrong?
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
> >
> > I also tried to use DT_SCHEMA_FILES so I can only test this one file,
> > but that wasn't working either:
>
> I see the errors immediately during testing, no special arguments needed:
>
> crosc64_dt_binding_check post-init-supplier.yaml
> make[1]: Entering directory '/home/krzk/dev/linux/linux/out'
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/post-init-supplier.example.dt=
s
> ../Documentation/devicetree/bindings/post-init-supplier.yaml:84:12:
> [error] syntax error: mapping values are not allowed here (syntax)
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> ../Documentation/devicetree/bindings/post-init-supplier.yaml:84:12:
> mapping values are not allowed in this context
> make[3]: *** [../Documentation/devicetree/bindings/Makefile:26:
> Documentation/devicetree/bindings/post-init-supplier.example.dts] Error 1
> make[3]: *** Deleting file
> 'Documentation/devicetree/bindings/post-init-supplier.example.dts'
> make[3]: *** Waiting for unfinished jobs....
> ../Documentation/devicetree/bindings/post-init-supplier.yaml:84:12:
> mapping values are not allowed in this context
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> /home/krzk/dev/linux/linux/Documentation/devicetree/bindings/post-init-su=
pplier.yaml:
> ignoring, error parsing file
> make[2]: *** [/home/krzk/dev/linux/linux/Makefile:1424:
> dt_binding_check] Error 2
> make[1]: *** [/home/krzk/dev/linux/linux/Makefile:240: __sub-make] Error =
2
> make[1]: Leaving directory '/home/krzk/dev/linux/linux/out'
> make: *** [Makefile:240: __sub-make] Error 2

I think I was just getting overwhelmed with the sea of error logs I
saw (for unrelated files). If I don't use the flags it's way too noisy
and it's not always the first thing that's reported.

This is what I see now and I think I now understand what to look for.

$ make DT_CHECKER_FLAGS=3D-m dt_binding_check
DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/post-init-suppliers.yam=
l
  LINT    Documentation/devicetree/bindings
./Documentation/devicetree/bindings/post-init-suppliers.yaml:84:12:
[error] syntax error: mapping values are not allowed here (syntax)
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
./Documentation/devicetree/bindings/post-init-suppliers.yaml:84:12:
mapping values are not allowed in this context
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
/mnt/android/linus-tree/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml=
:
ignoring, error in schema: properties
/mnt/android/linus-tree/Documentation/devicetree/bindings/post-init-supplie=
rs.yaml:
ignoring, error parsing file
/mnt/android/linus-tree/Documentation/devicetree/bindings/soc/tegra/nvidia,=
tegra20-pmc.yaml:
ignoring, error in schema: allOf: 0: then: properties: pinmux
/mnt/android/linus-tree/Documentation/devicetree/bindings/net/lantiq,pef225=
6.yaml:
ignoring, error in schema: properties: lantiq,data-rate-bps
/mnt/android/linus-tree/Documentation/devicetree/bindings/iio/pressure/hone=
ywell,mprls0025pa.yaml:
ignoring, error in schema: properties: honeywell,pmin-pascal
/mnt/android/linus-tree/Documentation/devicetree/bindings/iio/pressure/hone=
ywell,hsc030pa.yaml:
ignoring, error in schema: properties: honeywell,pmax-pascal
  DTEX    Documentation/devicetree/bindings/post-init-suppliers.example.dts
Documentation/devicetree/bindings/post-init-suppliers.yaml:84:12:
mapping values are not allowed in this context
make[2]: *** [Documentation/devicetree/bindings/Makefile:26:
Documentation/devicetree/bindings/post-init-suppliers.example.dts]
Error 1
make[2]: *** Deleting file
'Documentation/devicetree/bindings/post-init-suppliers.example.dts'
make[1]: *** [/mnt/android/linus-tree/Makefile:1432: dt_binding_check] Erro=
r 2
make: *** [Makefile:240: __sub-make] Error 2

>
>
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sou=
rces-with-the-devicetree-schema/
>
> I assume you develop on some older trees, because both next and v6.8-rc1
> work... or standard issues: old dtschema, old yamllint.
>
> I am afraid you do it for some old Android kernel... :(

No, I always develop on Linus's tree and test it on an android kernel
that's behind Linus's tree by a month or so.

My yamllint version is 1.32.0, but until 2 weeks ago the latest
yamllint version was 1.33.0.

And dt-schema is  2022.08.2-5 and I had to revert this from Linus's
tree to get it to work:
b32dcf23a03e dt-bindings: Drop kernel copy of common reserved-memory bindin=
gs

Unfortunately, AFAIK, I don't have permissions to change the package
repo, so can't really install a newer version.

Thanks for the tips.

-Saravana



-Saravana

