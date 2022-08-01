Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BF7586C24
	for <lists+linux-efi@lfdr.de>; Mon,  1 Aug 2022 15:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiHANlb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 1 Aug 2022 09:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiHANla (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 1 Aug 2022 09:41:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1764195BB
        for <linux-efi@vger.kernel.org>; Mon,  1 Aug 2022 06:41:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD998B811FB
        for <linux-efi@vger.kernel.org>; Mon,  1 Aug 2022 13:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774A2C433C1;
        Mon,  1 Aug 2022 13:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659361287;
        bh=INByKVuY9sd2Br1Rbuhk+zjM5qzi4VgHezGFPuLJ/TM=;
        h=From:To:Cc:Subject:Date:From;
        b=CcDWLJsX5ZOFOfQZJe0tlK2sBXNgANWYhA+Xd0CH4hGsPkZIoINl9c5mrQbtE4B9w
         ORZenP42g43yc2XBsxOYYUDI2ySjoqQ8IL64ANC/ytC9OSlbak8vp1vEAfDcJOFof9
         pRg1cmnSxGf1j9fzfVdcLyF/2Lew+k9Tpdd6KytXa99zgMYTtldzq7l/Fv6iKSSrN2
         gKeauWryKG3GhejHbpy7lmK+xqt1V95oirTSyAm2HlZ8yK5M9gvIVIuXL26CCVg6Ud
         K3USzgs2va4AqtGy9ZXtRNZFXxDkeZGQ/tejeu0/ehF+bJE2Ufwl9AkteiaCtWSj/I
         sYZGZ+gDsZJNA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL 0/2] EFI pull requests for v5.20
Date:   Mon,  1 Aug 2022 15:41:15 +0200
Message-Id: <20220801134117.1605678-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2495; i=ardb@kernel.org; h=from:subject; bh=INByKVuY9sd2Br1Rbuhk+zjM5qzi4VgHezGFPuLJ/TM=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi59f1acTuBsYDB7Y6K0iRslQIEQhp9fjDq6Hescoh UNJz0nGJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYufX9QAKCRDDTyI5ktmPJD91C/ 97RJ0kIlnFjAF15xHhMqjvzVjjhEBcWB/QuCp8d2MkCsZkaeC35RA6P0T0HI6s9vue5j/RW8XxV8Ud lKmJQsZ1UImtFA5HNrXUaXxfgV75LN0Tq+wSYIb1kHXU7xJsn2nxnWgXcc0qvTs5Kvj/CoeBU4bIWb WyXIK8CzKHAHdfRgkSLTkxmZN53WirFdVg1NheFWdByXD8j7kd6RnxknYbw7JYLewW3LLVn52tHMbj GRQVjkJUAqPY5nBvto7/NncATg1CP8y+fIG6Ywi1yB4jH+NrVzPoedcWXdaxoUGprYZ3udWokwsnUm PgK2VWWkV4hocXyNzgS7pPVDr/SsurdXTaUTJO0RswiBMNsWu6P4rLUEBnID5q2ysFJusn+B94Uk3E NmmSSl3Kzv+wbKd/ZAh8nBWvAmYrTRtCLthObV38byow6gxJdI2q6vUDSxjlY5Kt53uWWtOIPITpHk RddXfoKCB+MDhSzI58S2elC/1Jh7HcaxUkGP6Apw1sj7o=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Linus,

I am sending this cycle's EFI changes as two separate pull requests:
- the first one covers the normal updates accumulated this cycle, including
  some cleanup of the 'efivars' layer;
- the second one removes the obsolete 'efivars' sysfs driver, and consolidates
  the remaining code related to manipulating arbitrary EFI variables from user
  space into the efivarfs pseudo-filesystem driver.

The 'efivars' sysfs interface and the 'efivarfs' (note the 'f')
pseudo-filesystem are both based on an abstraction which is also called
'efivars' that caches EFI variables, and permits the backend to be swapped out,
for backing the EFI variable store by, e.g., SMI calls or other secure firmware
calls. (only used by Google SMI at the moment, but new uses are being
proposed).

Using two cached views of the same variable store leads to the problems you
might expect, and other users also exist that (ab)use the efivars layer for
non-obvious reasons.

Most of the quirks are being cleaned up in 1/2 of this PR series. However, to
really address this thoroughly, we should get rid of the obsolete sysfs based
EFI variable interface for user space, and only keep the efivarfs
pseudo-filesystem. This is what is implemented by 2/2 of this PR series, which
also moves the remaining efivars logic that efivarfs relies on into the
efivarfs driver, and no longer exports it to other parts of the kernel.

Obviously, removing the sysfs interface could potentially break someone's
workflow somewhere, and so it is not without risk. However, as far as I can
infer from things like Debian code search etc, all support libraries that are
in use to access EFI variables will prefer the efivarfs pseudo-filesystem, and
fall back to the sysfs interface otherwise.

The efivarfs pseudo-FS is 'default m' when CONFIG_EFI=y, and all the distros
have switched to it a very long time ago. But individual cases might exist
where a script accesses /sys/firmware/efi/vars/... directly, and this will no
longer work after merging PR 2/2 of this series.

In summary, I am leaving it up to you to pull the trigger on PR 2/2 - if you
prefer to deal with this in a different way, please feel free to disregard the
second PR, and make a suggestion how to address this instead.

Note that the 2/2 changes were put at the end so reverting this should be quite
straight-forward, in case we do decide to merge them and they turn out to be
causing problems.

Thanks,
Ard.
