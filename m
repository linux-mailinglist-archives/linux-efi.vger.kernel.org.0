Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A02F73EBB7
	for <lists+linux-efi@lfdr.de>; Mon, 26 Jun 2023 22:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjFZUUU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Jun 2023 16:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjFZUUS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Jun 2023 16:20:18 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D892E4
        for <linux-efi@vger.kernel.org>; Mon, 26 Jun 2023 13:20:14 -0700 (PDT)
Date:   Mon, 26 Jun 2023 20:20:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1687810808; x=1688070008;
        bh=uyx+e1KWA0+7qx7abSYLqISRgU0nnyFeOyk0lk1Cecg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=XoRZ5RnT3cYgqf7Dh4nxpp6F5yBUa+SvGufODYvLRQDRo6svRp7Qraa/kXe8NwaES
         iL1d3ZHc0xqx4ZLsS68i9G8YxQvTLiIUIl9edrc7SEC4PrN0aOvPOWsReCaJaUuc+o
         L/tui5mc36eUiZsab90Vh0Lppc/2NZTRbQFGFi0U9ZuvNNCRoET+jGt/okuDBwyUE+
         VCgBHlj4Tv3Yv/F/Myaw2a7MP420i3aTiU6eGeoSIPjfks/Rcxrveqdf8MMAWuGMxt
         KPytwQppVL1bGT3e6ZBqv+bsuCPj9mnzCUwdei1XF+iF7rzgFf6LV5m4sZQrw0SJTH
         W8I700Y9pSefA==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
From:   Sami Korkalainen <sami.korkalainen@proton.me>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: Re: [PATCH] efivarfs: Expose RandomSeed variable but with limited permissions
Message-ID: <GS7us6CqIqKV0TH2bXAsi8Q215e_0RCUIogJOvsYx43rfWDMJMncvcXC_iqWSgW_FUg1Svd9i_6i_XRUybcqMWflm5bpPlg-7dKaDVzlvh4=@proton.me>
In-Reply-To: <ZJmtiEk3UP6TpjNn@zx2c4.com>
References: <20230624180446.2048867-1-ardb@kernel.org> <ZJhSysqUcxOqh37n@zx2c4.com> <CAHk-=witNP7Ejgdk8YBZs5ujdxbjqYOVLdbtAsZC1NWoiPWkvA@mail.gmail.com> <OjqaFXzfhYptWcVhkBKPvd9th9zIokPME44PXC6DYfD5OYZ3iE-fVt-KJq0GKpc-6RrLcAS7CDcR5Gre1tWHXX57VkfJ0YlWmC4IfNb4et4=@proton.me> <ZJmtiEk3UP6TpjNn@zx2c4.com>
Feedback-ID: 45678890:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Monday, June 26th, 2023 at 18.23, Jason A. Donenfeld <Jason@zx2c4.com> w=
rote:

> Interesting! And after around 4 minutes, you don't see any stall
> warnings in your dmesg?
>

No stall warnings or other interesting messages. Between 30s and 600s, only=
 some [UFW BLOCK] messages and perf messages like this:

[  163.495537] perf: interrupt took too long (2517 > 2500), lowering kernel=
.perf_event_max_sample_rate to 79200

=E2=80=93Sami
