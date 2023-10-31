Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919947DD703
	for <lists+linux-efi@lfdr.de>; Tue, 31 Oct 2023 21:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjJaUWS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Oct 2023 16:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjJaUWS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Oct 2023 16:22:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55F2107
        for <linux-efi@vger.kernel.org>; Tue, 31 Oct 2023 13:22:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9C7C433C7;
        Tue, 31 Oct 2023 20:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698783735;
        bh=fHWBR2ATGMY6updA9EWrfl7Iv+3SUAyoG2xIXIIlpG0=;
        h=Date:From:To:Subject:From;
        b=zCNSEhw+30BghnHHUh+aSl9bcksJKE/rVqQLSI+ZeKjbAhCMYy1McUIYPmozh2gMg
         OMkdTQ3+f67CnuD5xYpTGitBB92uQPBOJUji92tfygWeJwBG7thc3nArmW8x+ewHrj
         nW4SeYuXigjzVJMCUU9mIN2pkcRPNgcgXy7dx3Uo=
Date:   Tue, 31 Oct 2023 16:22:14 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     linux-efi@vger.kernel.org
Subject: PSA: migrating linux-efi to new vger infrastructure
Message-ID: <20231031-magenta-mouflon-of-prestige-70b64a@nitro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Good day!

I plan to migrate the linux-efi@vger.kernel.org list to the new infrastructure
this week. We're still doing it list-by-list to make sure that we don't run
into scaling issues with the new infra.

The migration will be performed live and should not require any downtime.
There will be no changes to how anyone interacts with the list after
migration is completed, so no action is required on anyone's part.

Please let me know if you have any concerns.

Best wishes,
-K
