Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE0759A4DC
	for <lists+linux-efi@lfdr.de>; Fri, 19 Aug 2022 20:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354495AbiHSR2W (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Aug 2022 13:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352751AbiHSR1s (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Aug 2022 13:27:48 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC77E113688
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 09:46:05 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id d71so4094530pgc.13
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 09:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=3DiGzhF5dYX1PWabE8YuRNjHnwyaTzVabLfpgGZJsjY=;
        b=ICMpu1RXNgHLYy73gLZ+Huf6vrQUS+gDnmFqcfrAJ91h3kLgdgT2vYk8aT1pvovg7O
         caYrw/1IxHpSYmnfQ107f0+PFKsSZzGYg5rID/8ubYEFLffHbmrr77n1OGmYZyEWQvok
         Davh4rnhP4OpI7rK2zGJA/4R2V0uCCm6RHHJ5OOy2uqGAs5OU2R2S9xKeCkay+jVyrTI
         tc/tL+lVE8ano7tw0hvGmNGXV8apLAvRuBAR/CdR+RXxCcwd14ETNX/FKBxV74eyLhBU
         8qGUhYnZ4AMPuD87XWSqWZpti7CRo34OIurb6EeZ/Zp2brby+XJQqSdlnejiy8RDv/uG
         /cIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3DiGzhF5dYX1PWabE8YuRNjHnwyaTzVabLfpgGZJsjY=;
        b=Uq7SjLYc5lrVMRVGltxmfrvx2Vz++DyljyeHVDKtDJMAibBVXTbUPLqD7AS6rG6msx
         J2sSHzfM4OAxt92O7MdCHUnA/8sIh2CAyD+Lkf0HJgZMWfJSyC18NvAHy3RYgLuMMDC1
         liIALKKlXmvpcq9EUN/28QF2rVciy89Q0XD5sNeJgTqwcXMclDlhh8pZ8JpX1XFptEeD
         CRmc/vBiFvszUpUWvBNEddbSdByAWn1H+RF1PBoQT+cF+AZumwl0CGf1JIn0Ngzhn3CO
         zS7rB6bXbDr3YrytvtzK0kGi0EUQdIE/gGycxuFZ2oo86GMW8whXpfIeZ+mNES/ik7ZO
         Q3Lg==
X-Gm-Message-State: ACgBeo0kijWaGOpBZmBjUcIxHqBm/4PLEIisXdSp5TVYG9D/9TTkLEYi
        e3ycULOAJ9M1cFv6GkZHe1tvOcjGGUbdFF/Wm+U=
X-Google-Smtp-Source: AA6agR6QrvCqkT4PqzxgYZbXpo9y+dJOp+7frZcq3qnB4byF/DV/WSFuDFQ+UD/pFv09fYY4rpwJnyeqQnB0MqwC4YI=
X-Received: by 2002:a62:30c7:0:b0:52f:9a31:5935 with SMTP id
 w190-20020a6230c7000000b0052f9a315935mr8687554pfw.14.1660927563903; Fri, 19
 Aug 2022 09:46:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a11:511:b0:2bb:d3d6:55e2 with HTTP; Fri, 19 Aug 2022
 09:46:02 -0700 (PDT)
Reply-To: centricloanservice@gmail.com
From:   Centric Loan Services <abdulrahmna099@gmail.com>
Date:   Fri, 19 Aug 2022 17:46:02 +0100
Message-ID: <CAOiLf9h+hdGr0k6cZ8NHND-Eo8R0L73KZD5ef3KMzVGMwuUVqg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

--=20
Hei,

Onko sinulla vaikea saada lainaa vai tarvitsetko kiireesti
henkil=C3=B6kohtaisen tai yrityslainan 3 % korolla? Jos kyll=C3=A4. Ota yht=
eytt=C3=A4
jo t=C3=A4n=C3=A4=C3=A4n; tarvittava lainasumma: ja lainan tarkoitus: lis=
=C3=A4tietoja.

Keskeiset lainapalvelut.
