Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94297C826F
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 11:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjJMJsM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Oct 2023 05:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjJMJsM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Oct 2023 05:48:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6E195
        for <linux-efi@vger.kernel.org>; Fri, 13 Oct 2023 02:48:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F77C433C7
        for <linux-efi@vger.kernel.org>; Fri, 13 Oct 2023 09:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697190490;
        bh=8tHbeXuwh6czxq8fyXNeAORJuNNPifglzSw8yKsckQI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X0xGfjm+93XkAwY1F+nd021jhJncIMuH5Aj4Ka7+X0lplkF3wXIuPpSeoEqaELgQ0
         e/Lbg2q/zGAP9US2CNQeGwtr/2St0rI9lW76PsYXURFt3qyoetol3E4O2JasEwtj2L
         qaAKhYNWBe0j43CuxGgpgnDKsMh1q2yjKT3zveSIguFZxaA9zHQo3BqMki+xJmyTxy
         CYXRjUb0Xf68p3Y1xdmXtdW4QnqJkRP87kq+BWobkwztQlDa9UBn93vWQKm0QERTyt
         tBAcxKADrnA6ru+OWZINAWKZKJA7FR1MSuRJniifIRE5Sx/Uj2hISNkyuozzBDjjcW
         hHhQ0bStE27EA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so5436391fa.0
        for <linux-efi@vger.kernel.org>; Fri, 13 Oct 2023 02:48:10 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz8aZAsgtlL1ZI1YwBiOqb1VC8cUBS8eHaw/u+hpanVrKlBaxIx
        fNcm8zzjBrhG7MphWVeYFa3KQQj6L+aMpFaq7D4=
X-Google-Smtp-Source: AGHT+IFW1xkqd3RR/7Ay1AIU7yox2GK9lTvowkZTY6FchPBknohxx0u+4bo8gxqf1dFswrkI3/YUP+AFhbCD0E1JQHI=
X-Received: by 2002:a2e:9b15:0:b0:2bc:bcc6:d4ad with SMTP id
 u21-20020a2e9b15000000b002bcbcc6d4admr24663838lji.21.1697190488330; Fri, 13
 Oct 2023 02:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR11MB473998ADF68BD85D3B8798E49AD2A@DM6PR11MB4739.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB473998ADF68BD85D3B8798E49AD2A@DM6PR11MB4739.namprd11.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 13 Oct 2023 11:47:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGtuyn1wgCyGBpiehZNrpMGshgiVKAx=F5EO=-snLLZeQ@mail.gmail.com>
Message-ID: <CAMj1kXGtuyn1wgCyGBpiehZNrpMGshgiVKAx=F5EO=-snLLZeQ@mail.gmail.com>
Subject: Re: [Report] !!!! Can't find image information. !!!!
To:     "Miao, Jun" <jun.miao@intel.com>
Cc:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 13 Oct 2023 at 08:34, Miao, Jun <jun.miao@intel.com> wrote:
>
> Hi maintainer,
>
> When I add a efi_warn(=E2=80=9Cxxx=E2=80=9D) to below here, and boot it a=
s guest image, but fail.
>
> drivers/firmware/efi/libstub/x86-stub.c
>
> 599         case EFI_BOOT_SERVICES_DATA:
>
> 600         case EFI_CONVENTIONAL_MEMORY:
>
> 601 +        efi_warn("xxxxx test the efi_warn\n");
>
> 602             if (efi_soft_reserve_enabled() &&
>
>
>
> Boot it as guest image, and hang there:  Can't find image information.
>

You cannot use the console after ExitBootServices()
