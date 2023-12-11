Return-Path: <linux-efi+bounces-172-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B2A80D118
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 17:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353A11C212E9
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C344C62F;
	Mon, 11 Dec 2023 16:21:33 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97380B4;
	Mon, 11 Dec 2023 08:21:29 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1eb39505ba4so2791852fac.0;
        Mon, 11 Dec 2023 08:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702311689; x=1702916489;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=348QJQptRlElLNB1tIjm1p1XzL85PcSJzURBK+WTJok=;
        b=lQP5METhNOS+DVkzXJlq9AjePD9tjlVA0ThEiGgx27+/cdB19z3NEDnF1ajNXR5CBV
         /Ao+nX/rUTTAKXTNaIHqY/o/bB408tW27HM3e0/uzWznANiNmFd09CHgWGwzvxhjAghY
         2t7DDfyHb5i9yZAY8/nd8viUna616/qQafpM3aGfWYb7uLHyJn3IiZFHFoqD6Lqggplp
         pR6nCnE5FPGhLuz3Qzym3o6enTCn1FH3cO0BYNY7YLk/t4902ZliVv7oiDR/fzgZ6bWD
         GS93iHbQmRCScqpnS1j2IQq55/vKLE/el8gQmmu507Sl2R8Vv+6PSOk6se/bJiTj8hgH
         moHQ==
X-Gm-Message-State: AOJu0YxqjdrcxsuIzwHsIHLc/xMxX32wV8knO9qZhM4fdMXHOQF+HtNw
	Vhig18ONM3PZUmWgLMpdQQ==
X-Google-Smtp-Source: AGHT+IG4LPuDJKeXoC293asrqjuZQ2jvok4fn8Mx9ppkj4Ewou+tIJ9vo6O+pLBKP5opTLtBKO0hng==
X-Received: by 2002:a05:6870:82a0:b0:1fb:75b:99a4 with SMTP id q32-20020a05687082a000b001fb075b99a4mr6481626oae.83.1702311688423;
        Mon, 11 Dec 2023 08:21:28 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fw25-20020a056870081900b001fadabf6626sm2507717oab.23.2023.12.11.08.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:21:27 -0800 (PST)
Received: (nullmailer pid 2365869 invoked by uid 1000);
	Mon, 11 Dec 2023 16:21:26 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Davidlohr Bueso <dave@stgolabs.net>, linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-block@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, Herve Codina <herve.codina@bootlin.com>, Jens Axboe <axboe@kernel.dk>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-efi@vger.kernel.org, Richard Weinberger <richard@nod.at>
In-Reply-To: <20231211151244.289349-7-romain.gantois@bootlin.com>
References: <20231211151244.289349-1-romain.gantois@bootlin.com>
 <20231211151244.289349-7-romain.gantois@bootlin.com>
Message-Id: <170231168656.2365852.16098091734582168376.robh@kernel.org>
Subject: Re: [RFC PATCH 6/6] dt-bindings: mtd: add GPT partition bindings
Date: Mon, 11 Dec 2023 10:21:26 -0600


On Mon, 11 Dec 2023 16:12:42 +0100, Romain Gantois wrote:
> Allow parsing GPT layouts on MTD devices.
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  .../bindings/mtd/partitions/gpt.yaml          | 41 +++++++++++++++++++
>  .../bindings/mtd/partitions/partitions.yaml   |  1 +
>  2 files changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/gpt.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/mtd/partitions/gpt.yaml:11:1: [error] syntax error: could not find expected ':' (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/mtd/partitions/gpt.example.dts'
Documentation/devicetree/bindings/mtd/partitions/gpt.yaml:11:1: could not find expected ':'
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/mtd/partitions/gpt.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml:
while scanning a simple key
  in "<unicode string>", line 10, column 1
could not find expected ':'
  in "<unicode string>", line 11, column 1
./Documentation/devicetree/bindings/mtd/partitions/gpt.yaml:11:1: could not find expected ':'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/partitions/gpt.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231211151244.289349-7-romain.gantois@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


