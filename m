Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DA470B553
	for <lists+linux-efi@lfdr.de>; Mon, 22 May 2023 08:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjEVGsN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 May 2023 02:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjEVGrr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 May 2023 02:47:47 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98879189;
        Sun, 21 May 2023 23:45:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2532d6c7ef2so2206845a91.0;
        Sun, 21 May 2023 23:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684737932; x=1687329932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LjDrbtvTn67xGfPbBeqbRLDQjDn4H8fCj2S01FROHyU=;
        b=g/EFfzC9Z7HcAGAWKjt+aUgy6W0DPQMT+1xjQg5SPiT/Msoht7eDsHNHRYEAj4/crL
         XOCzG8Y/DbjXMeSeLDfOmZAoC4q6cfQV3/rZzFwBLCLcYSnu0hUosCqhrqeoJs5wO+b7
         7OKpQi66Td6/2/GnVUs7ljyJqUUBLkytW796W93fcp0+dSMfpLAGOkoH46dCevRr+Ey2
         LOr59k8DA5SigJdzK+7SDr3e7mg6kSSJ96WmLSOsh1rVoS59N/X0EPRwWM2BGQQYzjaf
         P488HrDSntk5LQxa4fmanQZYwyT6xuauZHWPn9MW8mitawxUt0LBYzQvaOpEFZwmtl/T
         JtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737932; x=1687329932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjDrbtvTn67xGfPbBeqbRLDQjDn4H8fCj2S01FROHyU=;
        b=CglWl7zEQ4yDupSdOBFhsLVKAO/bJw0TQaJZISJWu6K4Cyz0WeFF5VQpA43VSUrXv4
         PF1marU2VEF135a7Qimdm3lqIhyZLNqlQj2Nq6Dm5c0hP3y2T9P38bXWrDJovcetn/0z
         7BYGJgkzr3ZCf3yFJ0ejXwSCsKCYgrMXgVqL+tT8N+BFswoO1Ta11N2EizT6rsTai/dN
         WwOQpkjnMNxbb1cN0dol245d3R0N6gbwFagELwLeNjZ8kfJTy/2CQDFm/Odzbq8WkjCJ
         omk5NuY0blljIR2lQ01k+tYly4OUHnx4JzhPh+lTW7ZY7KnzlnGyj9OT6ns0oxSZu9QV
         +WSA==
X-Gm-Message-State: AC+VfDwGU4KzIALZP1sh58ZvAuPc7pPUYpxxtZgtXZ6EOkPBNpUV9G1q
        2NqVPGRH+PUIGmzzZIogSTg=
X-Google-Smtp-Source: ACHHUZ6hVR2GnXu1H1lD10qc8nxDW2RagqhHiOIeBdBCoqAFkjve7R17MHzRR8hknZmiBFsNFsXi4w==
X-Received: by 2002:a17:90a:db16:b0:250:1b4c:d861 with SMTP id g22-20020a17090adb1600b002501b4cd861mr10934788pjv.13.1684737932055;
        Sun, 21 May 2023 23:45:32 -0700 (PDT)
Received: from debian.me (subs09a-223-255-225-68.three.co.id. [223.255.225.68])
        by smtp.gmail.com with ESMTPSA id ha11-20020a17090af3cb00b0025368c90773sm5207523pjb.34.2023.05.21.23.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 23:45:31 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id D225F106ABB; Mon, 22 May 2023 13:45:28 +0700 (WIB)
Date:   Mon, 22 May 2023 13:45:28 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux EFI <linux-efi@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alan Bartlett <ajb@elrepo.org>
Subject: Re: Regression. -6.3.X Good. -6.4-rcY Bad.
Message-ID: <ZGsPiEq/yE1taACL@debian.me>
References: <8a79151b-ef75-08ad-ae3d-f6cdabfeaa47@gmail.com>
 <CAKbZUD3FBiaLGWq=TipfevqXP0SBz8F+=L6JSO+FMZOv0QQ9AQ@mail.gmail.com>
 <CAMj1kXEJj4+CFX3YfCZZu7RwxoVf=5PHZcZ8tG7x8xO3x4KPAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U1fv8V3wsTFbNp5O"
Content-Disposition: inline
In-Reply-To: <CAMj1kXEJj4+CFX3YfCZZu7RwxoVf=5PHZcZ8tG7x8xO3x4KPAw@mail.gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--U1fv8V3wsTFbNp5O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 08:33:47AM +0200, Ard Biesheuvel wrote:
> I've sent this out as a patch and queued it up as a EFI fix. Thanks!

Telling regzbot about the fix since Ard forgot to add required tags:

#regzbot fix: 3610dc36f4fd76

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--U1fv8V3wsTFbNp5O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZGsPiAAKCRD2uYlJVVFO
o7IkAQCfW5qyntrvODsBdWvQiLtt3bRqaM3rk/LVflVoxmAF9QEAjEkECq63YpYO
cKqqQjSu7Gqa7Naz0QTnCTXte8DzDwA=
=KFm8
-----END PGP SIGNATURE-----

--U1fv8V3wsTFbNp5O--
