Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EFB7B449A
	for <lists+linux-efi@lfdr.de>; Sun,  1 Oct 2023 01:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjI3Xih (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 30 Sep 2023 19:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjI3Xih (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 30 Sep 2023 19:38:37 -0400
Received: from mail1.bemta31.messagelabs.com (mail1.bemta31.messagelabs.com [67.219.246.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D55FAC;
        Sat, 30 Sep 2023 16:38:34 -0700 (PDT)
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSb0wbdRjmd732bkDxKJ38bDbnKi4q6bklkBz
  6wSULyzGMOqOImxk7xkG79d96ZTI2tbMKow63ESa2BeVPhgob0sEsRSgLEzO6okCoA5RY3GqE
  gZbObmHC4nXNGH5587zv8z7v83x4cYHEK5LhbImRNWgZtVwUi343sVmoKHZAdvNy1+PU1PVhE
  dVW8z1KXV8+JqSGuk8IKX95r4CyWswIdaO1GaHKpicB1THkFVBeUy51qs2DUhW32wDl9tciVD
  DQL6Tm/RU8uXiH37U9Qnn7vhZR1R0/8qK5P9CtUtqz0I3RZ6/OiWirpxOj7XOjCB1c2EM3lgc
  w+nK4AaXt3VUo3dQzg9B1deMIPf/vFYRuraxGaVNnmYj+2+0T0Z/fdiD0qPka9qpkl1ClzdeV
  7BUqT9/9Ceh7QIm1J4yZQCuwgFhcQnwGoKfxSyzaDAA4eLMeXWHO153l19bgKEHDM7+PYFF8G
  YWme4IIhsQTcLx/ULCiNs8tCaPNVwAuLzbdVwsIEo6fqRZFsJhIhIPWG2h0ngqbG27yapzHm2
  DYYoyMk4j1sKKqC4lgKaGAH5uvoJEVEUHBjvDr0QxPwSZHlzCCJTxu8M1g0etbYbs5jJwCEts
  qY9sqY9sqY9tD43qAtoB0jjUcYg2KdDLfoCpSGjWMSk0ypQqGLOYULMMZFVtI5h2OZDmO5A5r
  9qkLSC1rvAD4RykwxMR3gaDlHtkPHsMR+Vpx5m7IShLydQWHlQynzDMUq1muH5A4TgwPTYcAM
  RYMfYDIUK1Oy8qhOL2W3040sEVsSaFKzT/gAwHE4+VScdIXPC3m9IyGUxVFKQ/IxtsbensFuN
  PVx9fQwhhf/Zd+jkyGIzX8reWSQHLfQZYsbjzPnyAiJ5TF2hWDB08+CtbLksQgJiZGEq9nDRq
  V8f/8LEjGgTxJLDvHX4lXaY0rOWb5iAgf0fHCo5GIRuYhJTMh1qBzIOxmep8hiL7RP/dKj4t2
  zH9qPZFxdMK1NOmevDt7JPv905W/7j9E7atak0n43tsVOHhr05vHRxKm99ddrKnFWjY2xdU4n
  Vl7ptpdz28vPyD7SJa97dxIZXLNGz94NrgXny7758m4KYFtXdrA9pSBv0bUVamYL/eXrM7QYi
  DR/a7V7Gtuu5ArvqPLql83UgpdDrqw8LfYAoO31HfUpL/WPVRKvhVKeW6+3RnI0LydYc97mbT
  v/saV82FaHjchrTy5QTpWZ9mhh5lOTf6xNJ+mJQ6bsVJZcfWxr2Xp/AdfQadO2nN8ZaYXly6m
  f3IkJefA2pfqm68mbFtGdt7CUhvkKKdktjwrMHDMfwoY5XlfBAAA
X-Env-Sender: cesar.blanquel@sedatu.gob.mx
X-Msg-Ref: server-20.tower-690.messagelabs.com!1696117108!16957!1
X-Originating-IP: [187.217.48.5]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.107.4; banners=sedatu.gob.mx,-,-
X-VirusChecked: Checked
Received: (qmail 13165 invoked from network); 30 Sep 2023 23:38:29 -0000
Received: from mail.sedatu.gob.mx (HELO vmzmfep01.sedatu.gob.mx) (187.217.48.5)
  by server-20.tower-690.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Sep 2023 23:38:29 -0000
Received: from localhost (localhost [127.0.0.1])
        by vmzmfep01.sedatu.gob.mx (Postfix) with ESMTP id 8AF1D9A6B52;
        Sat, 30 Sep 2023 17:38:27 -0600 (CST)
Received: from vmzmfep01.sedatu.gob.mx ([127.0.0.1])
        by localhost (vmzmfep01.sedatu.gob.mx [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 51_pKiPGWK0y; Sat, 30 Sep 2023 17:38:27 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by vmzmfep01.sedatu.gob.mx (Postfix) with ESMTP id 543689A6B4F;
        Sat, 30 Sep 2023 17:38:26 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 vmzmfep01.sedatu.gob.mx 543689A6B4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sedatu.gob.mx;
        s=6DCD91FA-2103-11EA-A828-B793B0CC95F8; t=1696117106;
        bh=vYRP3VnV2N3FV52aFv5Marum2QUZYmcEs+BOT+DoGWc=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=no3jttL6nzXVY3AKWsuiq908omEsq9ACgAApgovSE5T93vPre7OCj8+L5A1QtsGBy
         mDU+zZHxR5YqSkcsMOZX4LyvyfFVjsq7QbLYdeV0rTt6zKt4+Juun+iyPbOWAPw9lP
         TfghgAQe2MZ35sq0tDKlb6a375Nwxn3+lC+7FEOTQXPxA6zYZjvS/ynnqhHES1vamB
         tlKMZV3WobRMQQpPu9jzrsPYkyrswfQDy0M6D6+Sf9pZtrKsGy3K6b/AAstQhtqo1I
         zJce3XCQW2PJGk3DHHFD80h+cUGFcNox318H8zQhHoYucKEkWrc9KKGnkZA6ixUH0I
         AG+92u5lW8IlA==
X-Virus-Scanned: amavisd-new at 
Received: from vmzmfep01.sedatu.gob.mx ([127.0.0.1])
        by localhost (vmzmfep01.sedatu.gob.mx [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dmNVqRX5zIGi; Sat, 30 Sep 2023 17:38:26 -0600 (CST)
Received: from [172.20.10.3] (fwr26.sedatu.gob.mx [10.0.2.26])
        by vmzmfep01.sedatu.gob.mx (Postfix) with ESMTPSA id 173339A6B41;
        Sat, 30 Sep 2023 17:38:06 -0600 (CST)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Yksityinen lahjoitus
To:     Recipients <cesar.blanquel@sedatu.gob.mx>
From:   "randomly selected" <cesar.blanquel@sedatu.gob.mx>
Date:   Sat, 30 Sep 2023 16:37:45 -0700
Reply-To: stevenoscaronline@gmail.com
Message-Id: <20230930233807.173339A6B41@vmzmfep01.sedatu.gob.mx>
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        TVD_SPACE_RATIO autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Yksityinen lahjoitus sinulle, Kristine Wellenstein. Ota yhteytt=E4 Barr.St=
even Oscariin; s=E4hk=F6postitse (stevenocarchamberonline@outlook.com) saa=
daksesi lis=E4tietoja / vaatimuksen

______________________________________________________________________
Este correo ha sido analizado por el servicio de Symantec Email Security.C=
loud.
Para m=E1s informaci=F3n, visite http://www.symanteccloud.com
______________________________________________________________________
