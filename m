Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D3A589468
	for <lists+linux-efi@lfdr.de>; Thu,  4 Aug 2022 00:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238964AbiHCW3p (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Aug 2022 18:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbiHCW3e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 Aug 2022 18:29:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF9C5E310
        for <linux-efi@vger.kernel.org>; Wed,  3 Aug 2022 15:29:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C748DB8227F
        for <linux-efi@vger.kernel.org>; Wed,  3 Aug 2022 22:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 829C6C43149;
        Wed,  3 Aug 2022 22:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659565766;
        bh=FEBJWn0cCtS1B+iC6iUd1E2cZtX5mSUh3sr7VNf+eqA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=B6jaC6ZPa3ayDKup9DW1XJ7/iD3oUEKJHUjoC4l2wH62+E/4TJ6LqWUqKuFk9QJ15
         ojOpXJAxICw0Pf+vqG7kSYn5SMXXafWgdPd38z/xP6sB5QU8W3hETnS90DXp/VD2Lt
         c/IFJ2EB/xkA6TyyoXLuhqov367QGY3WanWtGITZ7FS7fxLCA7WJYR9t8jcLMmgRM1
         i30TxwwsAc4ML/0MV3x/QHM52w8DOq5Tdy1hy6tYHQBGzzWsW41ssy+/MYmXPxTX7R
         upcPDehnjLxsDXeW52uHY1ALX9EGgN1j6dGqQ1CkJuLCqRXBgIoDyTsnpW0uxqPqSa
         29cER5mGYKduQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F695C43143;
        Wed,  3 Aug 2022 22:29:26 +0000 (UTC)
Subject: Re: [GIT PULL 1/2] EFI updates for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220801134117.1605678-2-ardb@kernel.org>
References: <20220801134117.1605678-1-ardb@kernel.org> <20220801134117.1605678-2-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220801134117.1605678-2-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.20
X-PR-Tracked-Commit-Id: e3435fff6ae03ca3ec1279299664f968478067e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97a77ab14ffac749ec2419c92ec2954111c22d22
Message-Id: <165956576645.24057.16402151012566324021.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Aug 2022 22:29:26 +0000
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-efi@vger.kernel.org,
        keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Mon,  1 Aug 2022 15:41:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97a77ab14ffac749ec2419c92ec2954111c22d22

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
