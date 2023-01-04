Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9335B65D734
	for <lists+linux-efi@lfdr.de>; Wed,  4 Jan 2023 16:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjADPWO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Jan 2023 10:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbjADPWC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Jan 2023 10:22:02 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0878EB1
        for <linux-efi@vger.kernel.org>; Wed,  4 Jan 2023 07:22:01 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id tz12so83414662ejc.9
        for <linux-efi@vger.kernel.org>; Wed, 04 Jan 2023 07:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=20LSKy+F6H/ibVso/7SWMiaNKhjpieAdY4EC6AFhBiE=;
        b=LahJ+an5Tr1vvuLs85cH742nMxkvgXxw6nMO54s105BDeWuqchnZz6NSMJUoJJ6sXe
         /s9+lzqsiwKlyG8WspgGDhVjfM6mr76+Cyt4YIlUxJtDWTzchY+otIpStyMLrDRY8Jmi
         3xdhf4opGUCATPnIRdvCgWHxZmS91/1/E1xDbOZmOcNTrlRyTxhnXQGI3RMvG5btgpKb
         5pgQd0VK3V+DUfaFrVQgzd2xWZBbJAMpIS/vAAInhHaJhIX1+dTuNvGOMuqBAges/8Bm
         oGeSmKc8dc/7qskXHKsI3c85ZN6jhOwPFI1wuZsn72A/9sVMP/a2pDeaCZELZ6muRMU5
         Qu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20LSKy+F6H/ibVso/7SWMiaNKhjpieAdY4EC6AFhBiE=;
        b=c+eQyaY3oiKoWSdBSXYqV/gUVF04gpbXiH4YTd8f+NW3UO986Y3oEZ7u5CSZV4i4DU
         kg9tlX/WaPXZOkqAEE5EoTdAaoHG5u6FPeePt3dPKJiWq3u4P+J4Pv/4rtQ9eZ/MBFC8
         g+1p08/+WWdELgKK+zT+mxvPzyBxj+gQgQ8ioTkzAQr1EMAcASkJfRuBJDbzpcw3Sb3B
         9riPJKif/kh8AMDgvMCuTKYJ5Vw37UoT0WP5SRLMgZUImQ62tefLpAEK28yY1aui9Flu
         kZmiPyrIhWDYDlEe1eRDiI3IOAqr64actCjpq8wzmUv45qnjophsUR40m2oct/Xy0C4D
         KjeA==
X-Gm-Message-State: AFqh2koa1up8cmrsYxmaU/9hbZ7u44MVYlgf/1JLQRgoH+9tfXvgN/fm
        3z6NJ9EkIGoNnR3pdaJfrJa+QQ==
X-Google-Smtp-Source: AMrXdXt3mbJSa2YwDa6Pb8OMitAoawu5ChBIZ3MotE5D5M4DWNFFNzvb8R/ZHGM+shSOMT7y6ieJXQ==
X-Received: by 2002:a17:907:9a98:b0:7c1:d4c:f08c with SMTP id km24-20020a1709079a9800b007c10d4cf08cmr41394995ejc.4.1672845720231;
        Wed, 04 Jan 2023 07:22:00 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id p15-20020a056402500f00b0047eeaae9558sm14780308eda.60.2023.01.04.07.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 07:21:59 -0800 (PST)
Date:   Wed, 4 Jan 2023 16:21:53 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        emil.renner.berthing@canonical.com, linux-efi@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        alexghiti@rivosinc.com
Subject: Re: [PATCH v3 12/14] efi/riscv: libstub: mark when compiling libstub
Message-ID: <20230104152153.ae7zki6iofc7ugbs@orel>
References: <20221130225614.1594256-1-heiko@sntech.de>
 <20221201193455.2hr6mwm6sa6vnd3w@kamzik>
 <CAMj1kXG=zM0EFFPn8MBWFurk=oSRPqwdd6CP1dudQC+JXV36Og@mail.gmail.com>
 <4822525.e9J7NaK4W3@diego>
 <CAMj1kXGBSLf4ppjA5_F4Ork+ZJ45Sk0w6SnPc3eDcWbTMkj3SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXGBSLf4ppjA5_F4Ork+ZJ45Sk0w6SnPc3eDcWbTMkj3SQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 02, 2022 at 05:37:16PM +0100, Ard Biesheuvel wrote:
> On Thu, 1 Dec 2022 at 23:39, Heiko Stübner <heiko@sntech.de> wrote:
> >
> > Hi Ard,
> >
> > Am Donnerstag, 1. Dezember 2022, 21:57:00 CET schrieb Ard Biesheuvel:
> > > On Thu, 1 Dec 2022 at 20:35, Andrew Jones <ajones@ventanamicro.com> wrote:
> > > >
> > > > On Wed, Nov 30, 2022 at 11:56:12PM +0100, Heiko Stuebner wrote:
> > > > > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > > > >
> > > > > We may want to runtime-optimize some core functions (str*, mem*),
> > > > > but not have this leak into libstub and cause build issues.
> > > > > Instead libstub, for the short while it's running, should just use
> > > > > the generic implementation.
> > > > >
> > > > > So, to be able to determine whether functions, that are used both in
> > > > > libstub and the main kernel, are getting compiled as part of libstub or
> > > > > not, add a compile-flag we can check via #ifdef.
> > > > >
> > > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > >
> > > I think it would be better to update arch/riscv/kernel/image-vars.h so
> > > that only these generic implementations are exposed to the stub in the
> > > first place.
> >
> 
> Actually, all references to string and memory functions are going away
> from the stub. This is already in -next.
> 
> EFI now has zboot support, which means you can create a EFI bootable
> kernel image that carries the actual kernel in compressed form rather
> than as a hybrid EFI/bare metal image.

While chatting about EFI stub string functions again in the context of [1]
we recalled this comment that states the references should be going away
anyway. I'm just replying here with interested parties on CC to try and
bring it back to the forefront.

[1] https://lore.kernel.org/all/20221216162141.1701255-5-alexghiti@rivosinc.com/

Thanks,
drew
