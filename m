Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801D57050C6
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 16:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjEPOb0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 10:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbjEPObY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 10:31:24 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEDD72B4
        for <linux-efi@vger.kernel.org>; Tue, 16 May 2023 07:31:21 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bc4bc2880so21693425a12.2
        for <linux-efi@vger.kernel.org>; Tue, 16 May 2023 07:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684247479; x=1686839479;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mhMTEtmnAgofUvsT7JdDd7CuFjDTNwQ0IePtBe84tf4=;
        b=RjQ6vBlPrLZrqaZibPuzPOyAcQ/N68F6X9g7mU07aWoQlYVkQmpNUoo/MoxMLr0o4/
         sOdCghqidlUJ2/yatZjMwldzrgMNdmwrwl9mkPK29F+KialT0N/Mgyt/pN9V7DW3zTnQ
         QxZs3Y/aLlDHf4tFTwYj0qAShWqfeV9ASoog8dw1pdsy4eZuR42ryP+SyMw9IBIO03ce
         3w5HZX5MjiF+YWUAWfO8uVH3ADI3M4/Rb5c35IhqGgG6sf3zv/dCu8RSDa1SxkKPRSlF
         O73ylzGd2uZDYRNXjvvMxXqNyxCA0cELAIcZWkb7cCPkdjb49TiJfn0zPvpKy6ofd2kC
         Mt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684247479; x=1686839479;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhMTEtmnAgofUvsT7JdDd7CuFjDTNwQ0IePtBe84tf4=;
        b=HLCYKS+K5oqs+AxqU+89eOwCRgk7ZEs4dbf0uxr2CunXWFaVZY85ABCGEG5zrgXyxO
         1euF6R+imRn9f+HNzTKgD1t8rgqn3uaxFtzFTAEuZZ14wfZzCYoBIs7yabuuHyiz23Xc
         wsw/ft6YU8bOjqPJ2979agSOuSy8cRJdtLJGdZP0W2659kO73tmj9Nr+ODZPr4y3FiPt
         pedIcCdDv/bT0CWwgFcUT+0lj6y4b5fEW8SyuESMvwcr9V+qBg3iMcesOvj358S2axTE
         NctzOruTyILJ8Zqh0CtKC1onRXTKYu2EA4tsqC5SBhf7XEijfkX72ZmIdw69AW/btKMC
         6O5Q==
X-Gm-Message-State: AC+VfDx3fnKArMk32aCfYWNTX0kUvGCodAOt6fiCrqWb5Il4lMjqMoKG
        MHEHuByLCt1eLVsr1Zusa59yZsNhRtfIdwhJxec=
X-Google-Smtp-Source: ACHHUZ5QKqqSi2ocS2x1810ACJVREO+lAlDubwfN+cq/HXGiulVDAWi9WFdFateC1tcKqrw65H5o1JQ8UNsbYMYW3r4=
X-Received: by 2002:a05:6402:202a:b0:50b:c804:46b8 with SMTP id
 ay10-20020a056402202a00b0050bc80446b8mr29382171edb.31.1684247478827; Tue, 16
 May 2023 07:31:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:c902:b0:4e:b15d:3b17 with HTTP; Tue, 16 May 2023
 07:31:17 -0700 (PDT)
Reply-To: sandrina.omaru2022@gmail.com
From:   Sandrina Omaru <omarusandrina04@gmail.com>
Date:   Tue, 16 May 2023 16:31:17 +0200
Message-ID: <CAPssEY9E8ZeWnf1Am6eVJEN2ou2Y5rG2BWdG54Ai6bCz3ARd_g@mail.gmail.com>
Subject: KOMPLIMENT DNEVA
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

KOMPLIMENT DNEVA

Z globokim spo=C5=A1tovanjem in poni=C5=BEnim priznanjem vas prosim, da nav=
edem
naslednjih nekaj vrstic v va=C5=A1o prijaznost. Upam, da boste prihranili
nekaj svojih dragocenih minut in s so=C4=8Dutjem prebrali ta poziv.
Priznati moram, da vam pi=C5=A1em to e-po=C5=A1tno sporo=C4=8Dilo z velikim=
 upanjem,
veseljem in navdu=C5=A1enjem, za katerega vem in z vero verjamem, da vas
mora zagotovo najti v dobrem zdravstvenem stanju.

Moje ime je Sandrina Omaru; Sem edini otrok mojih pokojnih star=C5=A1ev
Chief. G. Williams Omaru. Moj o=C4=8De je bil zelo ugleden poslovni magnet,
ki je v svojih dneh deloval v glavnem mestu Slonoko=C5=A1=C4=8Dene obale.

=C5=BDalostno je, da povem, da je skrivnostno umrl v Franciji med enim od
svojih poslovnih potovanj v tujino, =C4=8Deprav je njegovo nenadno smrt
povezoval ali bolje re=C4=8Deno domneval, da jo je na=C4=8Drtoval moj stric=
, ki
je takrat potoval z njim. Toda Bog pozna resnico! Moja mama je umrla,
ko sem bil star komaj 6 let, in od takrat me je o=C4=8De vzel tako
posebnega.

Pred smrtjo mojega o=C4=8Deta me je poklical in me obvestil, da ima vsoto
tri milijone =C5=A1eststo tiso=C4=8D evrov. (3.600.000,00 =E2=82=AC), ki ji=
h je
deponiral v zasebni banki tukaj v Abid=C5=BEanu, Slonoko=C5=A1=C4=8Dena oba=
la. Rekel
mi je, da je polo=C5=BEil denar na moje ime in mi dal tudi vse potrebne
pravne dokumente v zvezi s tem depozitom pri banki,

Star sem komaj 22 let in sem univerzitetni diplomant in res ne vem,
kaj naj naredim. Zdaj =C5=BEelim po=C5=A1tenega in BOGA boje=C4=8Dega partn=
erja v
tujini, ki mu lahko naka=C5=BEe ta denar z njegovo pomo=C4=8Djo, in po
transakciji bom pri=C5=A1el in stalno prebival v va=C5=A1i dr=C5=BEavi do t=
renutka,
ko bo primerno, da se vrnem domov, =C4=8De tako =C5=BEelja. To je zato, ker=
 sem
zaradi nenehne politi=C4=8Dne krize tukaj na Slonoko=C5=A1=C4=8Deni obali u=
trpel
veliko =C5=A1kode.

Smrt mojega o=C4=8Deta je pravzaprav prinesla =C5=BEalost v moje =C5=BEivlj=
enje. Prav
tako =C5=BEelim vlo=C5=BEiti sklad pod va=C5=A1im nadzorom, ker se ne spozn=
am na
poslovni svet. Iskreno si =C5=BEelim va=C5=A1e poni=C5=BEne pomo=C4=8Di v z=
vezi s tem.
Va=C5=A1e predloge in ideje bomo zelo cenili.

Prosim, upo=C5=A1tevajte to in se =C4=8Dim prej oglasite pri meni. Takoj po=
trdim
va=C5=A1o pripravljenost, poslal vam bom svojo sliko in vas obvestil o ve=
=C4=8D
podrobnostih v zvezi s to zadevo.

Prijazni pozdravi,

Sandrina Omaru.
