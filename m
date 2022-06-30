Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E70F5625A9
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jun 2022 23:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237617AbiF3Vyo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Jun 2022 17:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiF3Vyn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Jun 2022 17:54:43 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BBE564DE;
        Thu, 30 Jun 2022 14:54:43 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id d129so584148pgc.9;
        Thu, 30 Jun 2022 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=hkusf/I+psqk5rW3cP7Gl/cJmKwrAYd/DX73WJiRNgA=;
        b=NWT96R/CjSOLMCOw75p5A7SQaK5Qj/Do//wLI0sKhyeTNBp8zhbcRmkBNtJ7tp/oET
         6LQAdyYuVPPvPc65HFtJrzJvkgxHQdw/CIzPNKo7QrEH1MHaFpZ7DU1mAlgJT5aL5SWy
         ZV9CqAcW2gSaZ3SQcWUSt1FmCIIEmoPyaPxhZ4gcwJHMeOV5wTGZdu/Tc/P2vRtTuPXW
         91i6Brg4JffGktS6qpbc0/cqqHsNbZdib13OdkhPR1WDf2BCIqnBkgOcidg4wzVItLVb
         ICBbt4q9KAjWkBoOJuXzlA+A4JZ3+s5L5ECKUQZbbiRzr3x7ym9Ipzz1eO6NBR7wM1nP
         mJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hkusf/I+psqk5rW3cP7Gl/cJmKwrAYd/DX73WJiRNgA=;
        b=QjVErIP/Lf3AW0oVdnBdQJJsOgwSoqNJVlONjKn0z38j59PYM8eBSx8v66/ky4Zpnl
         IHjEy6ZNHcifijUCg15lv2c3vak5ImBJJwdL5dTn5wLX0L6M4bykZ+E8Y3f+lOJCxzH2
         JzY3tHuVPzc2sdKi4G4jUeqmO6mAh1HInbLp+Rwbpsj7bkdz39uJDuRgqE4L+qgVLIfO
         0IHgxrVvo1fN82Y4T/UOgkYBwIO48AJdIo9sYLfGgUO6DHQWG7oKxo/RyLw2666SeqqK
         77G7dNcWRFPtBhU45DGIh+ysc8JQEpODYq7g/iB0RsDRt7aqBmb5r5GUlsvAbuUmJ4IT
         uV8w==
X-Gm-Message-State: AJIora8VfGnX8p0ClTKZWxZTw6W2x6o/cvJZ7fiJMzjJNt2GGbxahO3u
        o/Kumwl2H2kLaW9VJlhm3oysEQ1PFiS/z3/zuNqsj0KLvZ9zSaXW
X-Google-Smtp-Source: AGRyM1smCYdmATUfFVrve6D92ZEZlb0u2AGoTmsF8R1ygzsMYkgiMsWTi2YbL5hIGxJPJNwjkPaiQzRBBvDruPm+TS8=
X-Received: by 2002:a63:4710:0:b0:410:ac39:831b with SMTP id
 u16-20020a634710000000b00410ac39831bmr9369035pga.395.1656626082869; Thu, 30
 Jun 2022 14:54:42 -0700 (PDT)
MIME-Version: 1.0
From:   Ariel Cabello Mateos <080ariel@gmail.com>
Date:   Thu, 30 Jun 2022 21:54:31 +0000
Message-ID: <CALRJROAKxEP4Dw93CoUS7SPdq=n5zDg7nbOwTW_bYdFhRREOcA@mail.gmail.com>
Subject: [Question] efi: First 512 bytes of image oddity.
To:     linux-efi@vger.kernel.org, ardb@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello:

I am not able to understand why the function efi_pe_entry in
drivers/firmware/efi/libstub/x86-stub.c
(which if im not mistaken its the first function executed in a efistub
kernel) does not copy the part of setup_header which is in the first
512 bytes of the kernel image.

There is a comment that says:

/*
* Fill out some of the header fields ourselves because the
* EFI firmware loader doesn't load the first sector.
*/

But from what I understood about the uefi spec, the boot firmware
should do a loadImage() which in turn does a OpenEx() in the file to
load it. It does not mention anything about not loading the 512 first
bytes of the image so... why does the stub do that?

Thanks in advance,
Ariel.
