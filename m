Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530FA66DDFE
	for <lists+linux-efi@lfdr.de>; Tue, 17 Jan 2023 13:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbjAQMqQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Jan 2023 07:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbjAQMqK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Jan 2023 07:46:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE41712857;
        Tue, 17 Jan 2023 04:46:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EF786136A;
        Tue, 17 Jan 2023 12:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90050C433F2;
        Tue, 17 Jan 2023 12:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673959559;
        bh=SPko2ysLze5qe6ltnGWqRen5dr1MwK5b8nRa3rXBPTE=;
        h=From:To:Cc:Subject:Date:From;
        b=BGeQDfWV1/pG+hqBWhPfHq10D8NFOoMGerc0GGp1sVbumUGJfna86/MJHjIgrdFEG
         15dwisNQtOxbmKOU3E/FBD3+RPhV/wcmj7+Wn/eKJfim+gxWs+8BB6UHtLvAg8qbKb
         wkCLfkLS7u5JPDuJLOX3WubhwowPGeRNGZHQQQodEFjom7iYAwdQcN7cJ+Dvd9a3Qj
         akBvxr/gbFwCtCtEiWtPiJsXYW+jsyiklFErwrjRKMScweQtoKUW4puh9iQTaQp29h
         ljemesv4R7cJrED4OBvYH+uHgeOhEKZUTMDa+XFeX+Dx1FXyDg+vQBVz42XiNMLTng
         EkHI+/zSKCMZQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pHlM5-0004Ml-C9; Tue, 17 Jan 2023 13:46:21 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] efi: efivars: drop kobject from efivars_register()
Date:   Tue, 17 Jan 2023 13:43:08 +0100
Message-Id: <20230117124310.16594-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Since the removal of the deprecated efivars sysfs interface there are
no users of the efivars kobject, which can be removed.

Included is also a related patch changing the return type of
efivar_supports_writes() to match the new efivar_is_available()
function.

Note that I intend to use efivar_is_available() in a driver with
optional EFI support (hence the dummy implementation) and the removal of
the kobject will simplify the upcoming Qualcomm UEFI Secure Application
driver somewhat too.

Johan


Johan Hovold (2):
  efi: efivars: drop kobject from efivars_register()
  efi: efivars: make efivar_supports_writes() return bool

 drivers/firmware/efi/efi.c     |  2 +-
 drivers/firmware/efi/vars.c    | 21 +++++++--------------
 drivers/firmware/google/gsmi.c |  2 +-
 fs/efivarfs/super.c            |  2 +-
 include/linux/efi.h            | 13 ++++++++-----
 5 files changed, 18 insertions(+), 22 deletions(-)

-- 
2.38.2

