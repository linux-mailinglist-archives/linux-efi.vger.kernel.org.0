Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBBD6C4D93
	for <lists+linux-efi@lfdr.de>; Wed, 22 Mar 2023 15:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjCVO0d (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Mar 2023 10:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjCVO0c (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 22 Mar 2023 10:26:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2BC570BA
        for <linux-efi@vger.kernel.org>; Wed, 22 Mar 2023 07:26:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 080DA6214F
        for <linux-efi@vger.kernel.org>; Wed, 22 Mar 2023 14:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9B5C433D2;
        Wed, 22 Mar 2023 14:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679495189;
        bh=ymyXouWT3/6fPAcOTkrCJcp889sI+sQsjqVxzTca/1w=;
        h=From:To:Cc:Subject:Date:From;
        b=BTGIFpXGi9o8D4MLPHrnZiEJQwJbQgsyBCq4VwUokdmW0GM8ZgKN9eJFOVqmmbEtB
         W2b0cJGHf2UMZmYhjfEJexqvRiti5NHfNupNtEd85t1rHvNHIw6mpEVRKVNvzu38QD
         ykPY3ibUUk97uh3TpAx7AzvczzOFz5WFFBTitRMJHWCSJZE4hpEaLKdTQ2fFBb3Yra
         sczppN+h5VVRcIRtF4OYOT3kMhZ1MnNAtfHviTFHrShu9O/zFmEq/JgkyXVk2oAZ/Y
         OT0/Kr3nYsUEWAa0Xw/+12zb9Bd/Zpolg8ulQ9tZHY6nrEQ7dzTZsMp+tneL7Wi5Hv
         OO3Q38OSV94og==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <darren@os.amperecomputing.com>,
        Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH 0/3] arm64: efi: Use SMBIOS type 4 record for Altra quirk
Date:   Wed, 22 Mar 2023 15:26:18 +0100
Message-Id: <20230322142621.3685058-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=888; i=ardb@kernel.org; h=from:subject; bh=ymyXouWT3/6fPAcOTkrCJcp889sI+sQsjqVxzTca/1w=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUVagFOS62TKTfdV0zkVGyysdUpj7y3Y/WvRmz2vD076e VS3c5dwRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiIwF6G/wFLNQpeV2wrvKrQ vaL80M4rX9n36LzMvjYl2Pr84fvB7hcZGfb3uqwJuvBXb02rIHORm8yqjApbMSGvLOE3MvFM6Y2 v+AA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We currently use the SMBIOS type 1 'family' string to identify Ampere
machines that require a EFI workaround, but this is not broad enough, as
OEMs often put arbitrary names in that field (such as 'Server')

So instead, let's use the SMBIOS type 4 records that describe the actual
CPU rather than the system.

Cc: Darren Hart <darren@os.amperecomputing.com>
Cc: Andrea Righi <andrea.righi@canonical.com>

Ard Biesheuvel (3):
  efi/libstub: smbios: Use length member instead of record struct size
  arm64: efi: Use SMBIOS processor version to key off Ampere quirk
  efi/libstub: smbios: Drop unused 'recsize' parameter

 drivers/firmware/efi/libstub/arm64.c   | 39 ++++++++++++++----
 drivers/firmware/efi/libstub/efistub.h | 42 ++++++++++++++++++--
 drivers/firmware/efi/libstub/smbios.c  | 15 +++++--
 3 files changed, 81 insertions(+), 15 deletions(-)

-- 
2.39.2

