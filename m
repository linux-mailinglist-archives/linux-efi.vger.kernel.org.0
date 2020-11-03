Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC5F2A5A17
	for <lists+linux-efi@lfdr.de>; Tue,  3 Nov 2020 23:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgKCW3q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Nov 2020 17:29:46 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:46532 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729342AbgKCW3q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Nov 2020 17:29:46 -0500
X-Greylist: delayed 4051 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Nov 2020 17:29:45 EST
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2B7FE12802ED;
        Tue,  3 Nov 2020 14:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1604442585;
        bh=pBusfGjxeube+7uMOO1vK2qWofcoaR2u16OA38DFSOo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=pY5X0X0lfzzv1/6W7Q9c7nPryHt67aHrAkUvGvlaZd4mlnaNm/wuno2TFI5n864BO
         MfHnJNdwXRDvRuJYaxqjMK7Twda9RWU2D86z8+mtmj424tme6Z7wv+vW0p0olte3dj
         PxxfjOYy4kvmBLu/9wWR14N5X8D+By2GvoISERxU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id z_PYRd_zlVyt; Tue,  3 Nov 2020 14:29:45 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 88C4912802EA;
        Tue,  3 Nov 2020 14:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1604442585;
        bh=pBusfGjxeube+7uMOO1vK2qWofcoaR2u16OA38DFSOo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=pY5X0X0lfzzv1/6W7Q9c7nPryHt67aHrAkUvGvlaZd4mlnaNm/wuno2TFI5n864BO
         MfHnJNdwXRDvRuJYaxqjMK7Twda9RWU2D86z8+mtmj424tme6Z7wv+vW0p0olte3dj
         PxxfjOYy4kvmBLu/9wWR14N5X8D+By2GvoISERxU=
Message-ID: <72a99913bb57893325e9457daf3f1af471eda498.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 0/7] efi/libstub: measurement initrd data loaded by
 the EFI stub
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Tue, 03 Nov 2020 14:29:43 -0800
In-Reply-To: <CACdnJuvC3EjQb5ZfOBynNzMPOwUm3w5CnXDCYGd10w_AW+_efw@mail.gmail.com>
References: <20201102170634.20575-1-ardb@kernel.org>
         <CACdnJuvC3EjQb5ZfOBynNzMPOwUm3w5CnXDCYGd10w_AW+_efw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2020-11-02 at 11:39 -0800, Matthew Garrett wrote:
> We should probably look at what Windows is doing here.

Here's a windows laptop log parsed using a tool we're working on.  It's
the same format as the Intel TSS log parser tool (yaml) simply with
additional fields.

The bootloader as measured by UEFI is event 25.  Everything after that
is windows specific.  You can see they do use an event separator but
only as they're about to call ExitBootServices and they only do
EV_COMPACT_HASH and EV_EVENT_TAG

James

---
events:
- EventNum: 0
  PCRIndex: 0
  EventType: EV_NO_ACTION
  Digest: '0000000000000000000000000000000000000000'
  EventSize: 33
  SpecID:
  - Signature: Spec ID Event03
    platformClass: 0
    specVersionMinor: 0
    specVersionMajor: 2
    specErrata: 0
    uintnSize: 2
    numberOfAlgorithms: 1
    Algorithms:
    - Algorithm[0]: null
      algorithmId: sha256
      digestSize: 32
    vendorInfoSize: 0
- EventNum: 1
  PCRIndex: 0
  EventType: EV_S_CRTM_VERSION
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: b4bff3baca8e02911e6480498e17c2e1f29e8e3f15c6d66357b6f7726103dcb=
b
  EventSize: 32
  Event: 4100560043004e0032003200570057002800560031002e003100320029000000
- EventNum: 2
  PCRIndex: 7
  EventType: EV_EFI_VARIABLE_DRIVER_CONFIG
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: ccfc4bb32888a345bc8aeadaba552b627d99348c767681ab3141f5b01e40a40=
e
  EventSize: 53
  Event:
    VariableName: 61dfe48b-ca93-d211-aa0d-00e098032b8c
    UnicodeNameLength: 10
    VariableDataLength: 1
    UnicodeName: SecureBoot
    VariableData:
      Enabled: 'Yes'
- EventNum: 3
  PCRIndex: 7
  EventType: EV_EFI_VARIABLE_DRIVER_CONFIG
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: 99bd2dfa6bc84d71dfb6a0597f234c3624e36dbb6382d888f3bf71abb67a493=
4
  EventSize: 888
  Event:
    VariableName: 61dfe48b-ca93-d211-aa0d-00e098032b8c
    UnicodeNameLength: 2
    VariableDataLength: 852
    UnicodeName: PK
    VariableData:
    - SignatureType: a5c059a1-94e4-4aa7-87b5-ab155c2bf072
      SignatureListSize: 852
      SignatureHeaderSize: 0
      SignatureSize: 824
      Keys:
      - SignatureOwner: e04fd794-033e-46a0-81d2-048e8da1432e
        SignatureData: 308203243082020ca0030201020210994f8b12db0c8db2496ed7=
0ffb2dd913300d06092a864886f70d01010b05003025312330210603550403131a547275737=
4202d204c656e6f766f204365727469666963617465301e170d313230363230303231363437=
5a170d3339313233313233353935395a301b311930170603550403131049646561706164205=
0726f647563747330820122300d06092a864886f70d01010105000382010f003082010a0282=
010100e1ec191df82e40a9100b226f1c5b998c82166b5269f10222f7dd7b32e31779326d08d=
9eed2f1185baa62806d6559a592360d2a52787df61b4a2e212e136af60d24dc8bd992e1b23b=
3c661f16379fd69dc69e1c551499124b1e7f61d30a5bd43fe5ed89e37a42585be5946d776a4=
c6e405dd9761ffce654558803ecf9a673eb6b5c0ea356a341f84dc3a04885c92ded5ad1bca7=
e40964cd60b6f4bd5a1809d112f6dad18daec9a2b6dfaf57f474bbfa6b509a6c6211849238f=
e76b63db95815676d7dc9c9396073f60f0f539ce0c7741f276ecc692daaf1c4ff351457df05=
0a4f7e38257ccbf5c058e48f27696cac4a8bd4c983dff3390ee2be80d5b61d3ca9a90203010=
001a35a305830560603551d01044f304d801062ee607e868018908830aaabd42db922a12730=
25312330210603550403131a5472757374202d204c656e6f766f20436572746966696361746=
582105ed2e5ff6bf8fd9e400960460aa2c007300d06092a864886f70d01010b050003820101=
00881d467574672a997af7d1915f9e5df15c8272646ff37144f1436df98c6374ac1cf8f5fcf=
942a9cf1b57016a4c4dc06757fc69b32db5b6a8c06e0c13e21702d999a9a1bb0c12cc6822ab=
787cd689414cb58f530e5d9aa5bbe4da7638339af372d0def9521a6967b855b94afff1a4d33=
2299895cb6c42827fb68335c1e5aaea703803b5762f4ab5197725647dd2217247d70c5032c8=
cc4c21d2b63b615a4df492b61f5dc21eb9794cfb25f7db66b8e42c3a2b14fe9ff492a8d351f=
5964956eb7bcbcfd6ab2f367243112cf0758735cee13a13d087d6bb5061dc2e9d244f10edfe=
93c5bd78ca505f13a12060d1f2520fba0142b999317e16595fefb2b4f2542765
- EventNum: 4
  PCRIndex: 7
  EventType: EV_EFI_VARIABLE_DRIVER_CONFIG
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: 63c0ee78eb49b91ac213b03768a827ebf9b12370f65851b19a883bf32eaf2a1=
4
  EventSize: 1598
  Event:
    VariableName: 61dfe48b-ca93-d211-aa0d-00e098032b8c
    UnicodeNameLength: 3
    VariableDataLength: 1560
    UnicodeName: KEK
    VariableData:
    - SignatureType: a5c059a1-94e4-4aa7-87b5-ab155c2bf072
      SignatureListSize: 1560
      SignatureHeaderSize: 0
      SignatureSize: 1532
      Keys:
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 308205e8308203d0a003020102020a610ad18800000000000330=
0d06092a864886f70d01010b0500308191310b3009060355040613025553311330110603550=
408130a57617368696e67746f6e3110300e060355040713075265646d6f6e64311e301c0603=
55040a13154d6963726f736f667420436f72706f726174696f6e313b3039060355040313324=
d6963726f736f667420436f72706f726174696f6e205468697264205061727479204d61726b=
6574706c61636520526f6f74301e170d3131303632343230343132395a170d3236303632343=
230353132395a308180310b3009060355040613025553311330110603550408130a57617368=
696e67746f6e3110300e060355040713075265646d6f6e64311e301c060355040a13154d696=
3726f736f667420436f72706f726174696f6e312a3028060355040313214d6963726f736f66=
7420436f72706f726174696f6e204b454b204341203230313130820122300d06092a864886f=
70d01010105000382010f003082010a0282010100c4e8b58abfad5726b026c3eae7fb577a44=
025d070dda4ae5742ae6b00fec6debec7fb9e35a63327c11174f0ee30ba73815938ec6f5e08=
4b19a9b2ce7f5b791d609e1e2c004a8ac301cdf48f306509a64a7517fc8854f8f2086cefe2f=
e19fff82c0ede9cdcef4536a623a0b43b9e225fdfe05f9d4c414ab11e223898d70b7a41d4de=
caee59cfa16c2d7c1cbd4e8c42fe599ee248b03ec8df28beac34afb4311120b7eb547926cdc=
e60489ebf53304eb10012a71e5f983133cff25092f687646ffba4fbedcad712a58aafb0ed27=
93de49b653bcc292a9ffc7259a2ebae92eff6351380c602ece45fcc9d76cdef6392c1af7940=
8479877fe352a8e89d7b07698f150203010001a382014f3082014b301006092b06010401823=
715010403020100301d0603551d0e0416041462fc43cda03ea4cb6712d25bd955ac7bccb68a=
5f301906092b0601040182371402040c1e0a00530075006200430041300b0603551d0f04040=
3020186300f0603551d130101ff040530030101ff301f0603551d2304183016801445665243=
e17e5811bfd64e9e2355083b3a226aa8305c0603551d1f045530533051a04fa04d864b68747=
4703a2f2f63726c2e6d6963726f736f66742e636f6d2f706b692f63726c2f70726f64756374=
732f4d6963436f725468695061724d6172526f6f5f323031302d31302d30352e63726c30600=
6082b0601050507010104543052305006082b060105050730028644687474703a2f2f777777=
2e6d6963726f736f66742e636f6d2f706b692f63657274732f4d6963436f725468695061724=
d6172526f6f5f323031302d31302d30352e637274300d06092a864886f70d01010b05000382=
020100d48488f514941802ca2a3cfb2a921c0cd7a0d1f1e85266a8eea2b5757a9000aa2da47=
65aea79b7b9376a517b1064f6e164f20267bef7a81b78bdbace8858640cd657c819a35f05d6=
dbc6d069ce484b32b7eb5dd230f5c0f5b8ba7807a32bfe9bdb345684ec82caae4125709c6be=
9fe900fd7961fe5e7941fb22a0c8d4bff2829107bf7d77ca5d176b905c879ed0f90929cc2fe=
df6f7e6c0f7bd4c145dd345196390fe55e56d8180596f407a642b3a077fd0819f27156cc9f8=
623a487cba6fd587ed4696715917e81f27f13e50d8b8a3c8784ebe3cebd43e5ad2d84938e6a=
2b5a7c44fa52aa81c82d1cbbe052df0011f89a3dc160b0e133b5a388d165190a1ae7ac7ca4c=
182874e38b12f0dc514876ffd8d2ebc39b6e7e6c3e0e4cd2784ef9442ef298b9046413b811b=
67d8f9435965cb0dbcfd00924ff4753ba7a924fc50414079e02d4f0a6a27766e52ed96697ba=
f0ff78705d045c2ad5314811ffb3004aa373661da4a691b34d868edd602cf6c940cd3cf6c22=
79adb1f0bc03a24660a9c407c22182f1fdf2e8793260bfd8aca522144bcac1d84beb7d3f573=
5b2e64f75b4b060032253ae91791dd69b411f15865470b2de0d350f7cb03472ba97603bf079=
eba2b21c5da216b887c5e91bf6b597256f389fe391fa8a7998c3690eb7a31c200597f8ca14a=
e00d7c4f3c01410756b34a01bb59960f35cb0c5574e36d23284bf9e
- EventNum: 5
  PCRIndex: 7
  EventType: EV_EFI_VARIABLE_DRIVER_CONFIG
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: e938fba630de62bbc22df8ccd40c6b349830155f1049f8da54520ae97a5e37b=
0
  EventSize: 4029
  Event:
    VariableName: cbb219d7-3a3d-9645-a3bc-dad00e67656f
    UnicodeNameLength: 2
    VariableDataLength: 3993
    UnicodeName: db
    VariableData:
    - SignatureType: a5c059a1-94e4-4aa7-87b5-ab155c2bf072
      SignatureListSize: 1543
      SignatureHeaderSize: 0
      SignatureSize: 1515
      Keys:
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 308205d7308203bfa003020102020a6107765600000000000830=
0d06092a864886f70d01010b0500308188310b3009060355040613025553311330110603550=
408130a57617368696e67746f6e3110300e060355040713075265646d6f6e64311e301c0603=
55040a13154d6963726f736f667420436f72706f726174696f6e31323030060355040313294=
d6963726f736f667420526f6f7420436572746966696361746520417574686f726974792032=
303130301e170d3131313031393138343134325a170d3236313031393138353134325a30818=
4310b3009060355040613025553311330110603550408130a57617368696e67746f6e311030=
0e060355040713075265646d6f6e64311e301c060355040a13154d6963726f736f667420436=
f72706f726174696f6e312e302c060355040313254d6963726f736f66742057696e646f7773=
2050726f64756374696f6e20504341203230313130820122300d06092a864886f70d0101010=
5000382010f003082010a0282010100dd0cbba2e42e09e3e7c5f79669bc0021bd693333efad=
04cb5480ee0683bbc52084d9f7d28bf338b0aba4ad2d7c627905ffe34a3f04352070e3c4e76=
be09cc03675e98a31dd8d70e5dc37b5744696285b8760232cbfdc47a567f751279e72eb07a6=
c9b91e3b53357ce5d3ec27b9871cfeb9c923096fa84691c16e963c41d3cba33f5d026a4dec6=
91f25285c36fffd43150a94e019b4cfdfc212e2c25b27ee2778308b5b2a096b22895360162c=
c0681d53baec49f39d618c85680973445d7da2542bdd79f715cf355d6c1c2b5ccebc9c238b6=
f6eb526d93613c34fd627aeb9323b41922ce1c7cd77e8aa544ef75c0b048765b44318a8b2e0=
6d1977ec5a24fa48030203010001a38201433082013f301006092b060104018237150104030=
20100301d0603551d0e04160414a92902398e16c49778cd90f99e4f9ae17c55af5330190609=
2b0601040182371402040c1e0a00530075006200430041300b0603551d0f040403020186300=
f0603551d130101ff040530030101ff301f0603551d23041830168014d5f656cb8fe8a25c62=
68d13d94905bd7ce9a18c430560603551d1f044f304d304ba049a0478645687474703a2f2f6=
3726c2e6d6963726f736f66742e636f6d2f706b692f63726c2f70726f64756374732f4d6963=
526f6f4365724175745f323031302d30362d32332e63726c305a06082b06010505070101044=
e304c304a06082b06010505073002863e687474703a2f2f7777772e6d6963726f736f66742e=
636f6d2f706b692f63657274732f4d6963526f6f4365724175745f323031302d30362d32332=
e637274300d06092a864886f70d01010b0500038202010014fc7c7151a579c26eb2ef393ebc=
3c520f6e2b3f101373fea868d048a6344d8a960526ee3146906179d6ff382e456bf4c0e528b=
8da1d8f8adb09d71ac74c0a36666a8cec1bd70490a81817a49bb9e240323676c4c15ac6bfe4=
04c0ea16d3acc368ef62acdd546c503058a6eb7cfe94a74e8ef4ec7c867357c2522173345af=
3a38a56c804da0709edf88be3cef47e8eaef0f60b8a08fb3fc91d727f53b8ebbe63e0e33d31=
65b081e5f2accd16a49f3da8b19bc242d090845f541dff89eaba1d47906fb0734e419f409f5=
fe5a12ab21191738a2128f0cede73395f3eab5c60ecdf0310a8d309e9f4f69685b67f518866=
47198da2b0123d812a680577bb914c627bb6c107c7ba7a8734030e4b627a99e9cafcce4a37c=
92da4577c1cfe3ddcb80f5afad6c4b30285023aeab3d96ee4692137de81d1f675190567d393=
575e291b39c8ee2de1cde445735bd0d2ce7aab1619824658d05e9d81b367af6c35f2bce53f2=
4e235a20a7506f6185699d4782cd1051bebd088019daa10f105dfba7e2c63b7069b2321c4f9=
786ce2581706362b911203cca4d9f22dbaf9949d40ed1845f1ce8a5c6b3eab03d370182a0a6=
ae05f47d1d5630a32f2afd7361f2a705ae5425908714b57ba7e8381f0213cf41cc1c5b99093=
0e88459386e9b12099be98cbc595a45d62d6a0630820bd7510777d3df345b99f979fcb57806=
f33a904cf77a4621c597e
    - SignatureType: a5c059a1-94e4-4aa7-87b5-ab155c2bf072
      SignatureListSize: 1600
      SignatureHeaderSize: 0
      SignatureSize: 1572
      Keys:
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 30820610308203f8a003020102020a6108d3c400000000000430=
0d06092a864886f70d01010b0500308191310b3009060355040613025553311330110603550=
408130a57617368696e67746f6e3110300e060355040713075265646d6f6e64311e301c0603=
55040a13154d6963726f736f667420436f72706f726174696f6e313b3039060355040313324=
d6963726f736f667420436f72706f726174696f6e205468697264205061727479204d61726b=
6574706c61636520526f6f74301e170d3131303632373231323234355a170d3236303632373=
231333234355a308181310b3009060355040613025553311330110603550408130a57617368=
696e67746f6e3110300e060355040713075265646d6f6e64311e301c060355040a13154d696=
3726f736f667420436f72706f726174696f6e312b3029060355040313224d6963726f736f66=
7420436f72706f726174696f6e2055454649204341203230313130820122300d06092a86488=
6f70d01010105000382010f003082010a0282010100a5086c4cc745096a4b0ca4c0877f0675=
0c43015464e0167f07ed927d0bb273bf0c0ac64a4561a0c5162d96d3f52ba0fb4d499b41809=
03cb954fde6bcd19dc4a4188a7f418a5c59836832bb8c47c9ee71bc214f9a8a7cff443f8d8f=
32b22648ae75b5eec94c1e4a197ee4829a1d78774d0cb0bdf60fd316d3bcfa2ba551385df5f=
bbadb7802dbffec0a1b96d583b81913e9b6c07b407be11f2827c9faef565e1ce67e947ec0f0=
44b27939e5dab2628b4dbf3870e2682414c933a40837d558695ed37cedc1045308e74eb02a8=
76308616f631559eab22b79d70c61678a5bfd5ead877fba86674f71581222042222ce8bef54=
7100ce503558769508ee6ab1a201d50203010001a382017630820172301206092b060104018=
237150104050203010001302306092b060104018237150204160414f8c16bb77f77534af325=
371d4ea1267b0f207080301d0603551d0e0416041413adbf4309bd82709c8cd54f316ed5229=
88a1bd4301906092b0601040182371402040c1e0a00530075006200430041300b0603551d0f=
040403020186300f0603551d130101ff040530030101ff301f0603551d23041830168014456=
65243e17e5811bfd64e9e2355083b3a226aa8305c0603551d1f045530533051a04fa04d864b=
687474703a2f2f63726c2e6d6963726f736f66742e636f6d2f706b692f63726c2f70726f647=
56374732f4d6963436f725468695061724d6172526f6f5f323031302d31302d30352e63726c=
306006082b0601050507010104543052305006082b060105050730028644687474703a2f2f7=
777772e6d6963726f736f66742e636f6d2f706b692f63657274732f4d6963436f7254686950=
61724d6172526f6f5f323031302d31302d30352e637274300d06092a864886f70d01010b050=
00382020100350842ff30cccef7760cad1068583529463276277cef124127421b4aaa6d8138=
48591355f3e95834a6160b82aa5dad82da808341068fb41df203b9f31a5d1bf15090f9b3558=
442281c20bdb2ae5114c5c0ac9795211c90db0ffc779e95739188cabdbd52b905500ddf579e=
a061ed0de56d25d9400f1740c8cea34ac24daf9a121d08548fbdc7bcb92b3d492b1f32fc6a2=
1694f9bc87e4234fc3606178b8f2040c0b39a257527cdc903a3f65dd1e736547ab950b5d312=
d107bfbb74dfdc1e8f80d5ed18f42f14166b2fde668cb023e5c784d8edeac13382ad564b182=
df1689507cdcff072f0aebbdd8685982c214c332bf00f4af06887b592553275a16a826a3ca3=
2511a4edadd704aecbd84059a084d1954c6291221a741d8c3d470e44a6e4b09b3435b1fab65=
3a82c81eca40571c89db8bae81b4466e447540e8e567fb39f1698b286d0683e9023b52f5e8f=
50858dc68d825f41a1f42e0de099d26c75e4b669b52186fa07d1f6e24dd1daad2c77531e253=
237c76c52729586b0f135616a19f5b23b815056a6322dfea289f94286271855a182ca5a9bf8=
30985414a64796252fc826e441941a5c023fe596e3855b3c3e3fbb47167255e22522b1d97be=
703062aa3f71e9046c3000dd61989e30e352762037115a6efd027a0a0593760f83894b8e078=
70f8ba4c868794f6e0ae0245ee65c2b6a37e69167507929bf5a6bc598358
    - SignatureType: a5c059a1-94e4-4aa7-87b5-ab155c2bf072
      SignatureListSize: 850
      SignatureHeaderSize: 0
      SignatureSize: 822
      Keys:
      - SignatureOwner: e04fd794-033e-46a0-81d2-048e8da1432e
        SignatureData: 308203223082020aa003020102021090a1987d32a9f6bf478ae2=
88af9a3bbc300d06092a864886f70d01010b05003025312330210603550403131a547275737=
4202d204c656e6f766f204365727469666963617465301e170d313831303130303230323137=
5a170d3339313233313233353935395a3019311730150603550403130e4156593734302d313=
5313749434830820122300d06092a864886f70d01010105000382010f003082010a02820101=
00c604c8ce9824e5b33415144a3c2e918645206acb3270894fe291f9087438cfcb03bface9b=
d6971dddfd53efa6bfad8fe3021391b63815eabf7307bd76d701150b998ce238fe7e90bf63b=
2da85cf55505604e1f53ea6d0b0b056390e648525750685d7890bc797637b541864bd611b85=
702cc327ab979e96097d9c217da3ae66d555b4cea1f5cdf65b8461dc638dbc21efb3d0beb7e=
4d4379e172064a7b7f117336c1383d415c6acd53e69db28229137af237b0bc66aed119a5557=
01e0d76ab7ba2ba7d9aea3b14bb52316ed843816429930e9b5ddb59463031617525bb159d81=
b6c8c73157e72b0e764a322d227a4d8759a6894cfcbf77bb0b8bb2101a9c38e10203010001a=
35a305830560603551d01044f304d801062ee607e868018908830aaabd42db922a127302531=
2330210603550403131a5472757374202d204c656e6f766f204365727469666963617465821=
05ed2e5ff6bf8fd9e400960460aa2c007300d06092a864886f70d01010b0500038201010022=
38cd3a0caeb4b266ecec850285a56b0dd971ee5d1d79880bd54f9ad3dc3c823af591cf4967f=
a07f47b2d92f22d6fb1e6a5f489e3b160a0763e63f5858c767eac2b9460850cad8444bb0751=
688e66bc5615998f125bdcb4b11d1763875f94641a310a6e896fb68f3ebdc67742b335e09d0=
414285babb59fb2060727c85fe78b6abc93c1de2d857ed145dba37165c508e258c2a99e0f9d=
051c5a5bf7f4f1adc4d0bb6ce7d7755e95ed812da519c1323924b6bd078ce84f0db22f14b3e=
2b28a21a68ef267836dc1e6e4fd8f7b02f2e849cb91f0a87bd75764e47e6b81c26429873d17=
da82c102d76f36b5d5d7ee168329f579d1b67f030802ee606d41b07c5fb9
- EventNum: 6
  PCRIndex: 7
  EventType: EV_EFI_VARIABLE_DRIVER_CONFIG
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: 37f3fc46a22afd57abb467c81982d6274362009ad60141e4b8e939ddc5789df=
5
  EventSize: 4050
  Event:
    VariableName: cbb219d7-3a3d-9645-a3bc-dad00e67656f
    UnicodeNameLength: 3
    VariableDataLength: 4012
    UnicodeName: dbx
    VariableData:
    - SignatureType: c1c41626-504c-4092-aca9-41f936934328
      SignatureListSize: 4012
      SignatureHeaderSize: 0
      SignatureSize: 48
      Keys:
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 80b4d96931bf0d02fd91a61e19d14f1da452e66db2408ca8604d=
411f92659f0a
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: f52f83a3fa9cfbd6920f722824dbe4034534d25b8507246b3b95=
7dac6e1bce7a
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: c5d9d8a186e2c82d09afaa2a6f7f2e73870d3e64f72c4e08ef67=
796a840f0fbd
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 363384d14d1f2e0b7815626484c459ad57a318ef4396266048d0=
58c5a19bbf76
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 1aec84b84b6c65a51220a9be7181965230210d62d6d33c48999c=
6b295a2b0a06
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: e6ca68e94146629af03f69c2f86e6bef62f930b37c6fbcc878b7=
8df98c0334e5
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: c3a99a460da464a057c3586d83cef5f4ae08b7103979ed893274=
2df0ed530c66
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 58fb941aef95a25943b3fb5f2510a0df3fe44c58c95e0ab80487=
297568ab9771
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 5391c3a2fb112102a6aa1edc25ae77e19f5d6f09cd09eeb25099=
22bfcd5992ea
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: d626157e1d6a718bc124ab8da27cbb65072ca03a7b6b257dbdcb=
bd60f65ef3d1
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: d063ec28f67eba53f1642dbf7dff33c6a32add869f6013fe162e=
2c32f1cbe56d
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 29c6eb52b43c3aa18b2cd8ed6ea8607cef3cfae1bafe1165755c=
f2e614844a44
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 90fbe70e69d633408d3e170c6832dbb2d209e0272527dfb63d49=
d29572a6f44c
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 075eea060589548ba060b2feed10da3c20c7fe9b17cd026b94e8=
a683b8115238
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 07e6c6a858646fb1efc67903fe28b116011f2367fe92e6be2b36=
999eff39d09e
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 09df5f4e511208ec78b96d12d08125fdb603868de39f6f729278=
52599b659c26
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 0bbb4392daac7ab89b30a4ac657531b97bfaab04f90b0dafe5f9=
b6eb90a06374
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 0c189339762df336ab3dd006a463df715a39cfb0f492465c600e=
6c6bd7bd898c
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 0d0dbeca6f29eca06f331a7d72e4884b12097fb348983a2a14a0=
d73f4f10140f
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 0dc9f3fb99962148c3ca833632758d3ed4fc8d0b0007b95b31e6=
528f2acd5bfc
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 106faceacfecfd4e303b74f480a08098e2d0802b936f8ec774ce=
21f31686689c
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 174e3a0b5b43c6a607bbd3404f05341e3dcf396267ce94f8b50e=
2e23a9da920c
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 18333429ff0562ed9f97033e1148dceee52dbe2e496d5410b5cf=
d6c864d2d10f
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 2b99cf26422e92fe365fbf4bc30d27086c9ee14b7a6fff44fb2f=
6b9001699939
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 2bbf2ca7b8f1d91f27ee52b6fb2a5dd049b85a2b9b529c5d6662=
068104b055f8
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 2c73d93325ba6dcbe589d4a4c63c5b935559ef92fbf050ed50c4=
e2085206f17d
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 2e70916786a6f773511fa7181fab0f1d70b557c6322ea923b2a8=
d3b92b51af7d
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 306628fa5477305728ba4a467de7d0387a54f569d3769fce5e75=
ec89d28d1593
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 3608edbaf5ad0f41a414a1777abf2faf5e670334675ec3995e69=
35829e0caad2
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 3841d221368d1583d75c0a02e62160394d6c4e0a6760b6f607b9=
0362bc855b02
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 3fce9b9fdf3ef09d5452b0f95ee481c2b7f06d743a737971558e=
70136ace3e73
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 4397daca839e7f63077cb50c92df43bc2d2fb2a8f59f26fc7a0e=
4bd4d9751692
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 47cc086127e2069a86e03a6bef2cd410f8c55a6d6bdb362168c3=
1b2ce32a5adf
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 518831fe7382b514d03e15c621228b8ab65479bd0cbfa3c5c1d0=
f48d9c306135
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 5ae949ea8855eb93e439dbc65bda2e42852c2fdf6789fa146736=
e3c3410f2b5c
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 6b1d138078e4418aa68deb7bb35e066092cf479eeb8ce4cd12e7=
d072ccb42f66
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 6c8854478dd559e29351b826c06cb8bfef2b94ad3538358772d1=
93f82ed1ca11
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 6f1428ff71c9db0ed5af1f2e7bbfcbab647cc265ddf5b293cdb6=
26f50a3a785e
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 71f2906fd222497e54a34662ab2497fcc81020770ff51368e9e3=
d9bfcbfd6375
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 726b3eb654046a30f3f83d9b96ce03f670e9a806d1708a0371e6=
2dc49d2c23c1
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 72e0bd1867cf5d9d56ab158adf3bddbc82bf32a8d8aa1d8c5e2f=
6df29428d6d8
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 7827af99362cfaf0717dade4b1bfe0438ad171c15addc248b75b=
f8caa44bb2c5
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 81a8b965bb84d3876b9429a95481cc955318cfaa1412d808c8a3=
3bfd33fff0e4
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 82db3bceb4f60843ce9d97c3d187cd9b5941cd3de8100e586f2b=
da5637575f67
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 895a9785f617ca1d7ed44fc1a1470b71f3f1223862d9ff9dcc3a=
e2df92163daf
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 8ad64859f195b5f58dafaa940b6a6167acd67a886e8f46936417=
7221c55945b9
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 8bf434b49e00ccf71502a2cd900865cb01ec3b3da03c35be505f=
df7bd563f521
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 8d8ea289cfe70a1c07ab7365cb28ee51edd33cf2506de888fbad=
d60ebf80481c
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 9998d363c491be16bd74ba10b94d9291001611736fdca643a366=
64bc0f315a42
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 9e4a69173161682e55fde8fef560eb88ec1ffedcaf04001f66c0=
caf707b2b734
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: a6b5151f3655d3a2af0d472759796be4a4200e5495a7d869754c=
4848857408a7
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: a7f32f508d4eb0fead9a087ef94ed1ba0aec5de6f7ef6ff0a62b=
93bedf5d458d
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: ad6826e1946d26d3eaf3685c88d97d85de3b4dcb3d0ee2ae81c7=
0560d13c5720
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: aeebae3151271273ed95aa2e671139ed31a98567303a332298f8=
3709a9d55aa1
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: afe2030afb7d2cda13f9fa333a02e34f6751afec11b010dbcd44=
1fdf4c4002b3
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: b54f1ee636631fad68058d3b0937031ac1b90ccb17062a391cca=
68afdbe40d55
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: b8f078d983a24ac433216393883514cd932c33af18e7dd70884c=
8235f4275736
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: b97a0889059c035ff1d54b6db53b11b9766668d9f955247c028b=
2837d7a04cd9
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: bc87a668e81966489cb508ee805183c19e6acd24cf17799ca062=
d2e384da0ea7
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: c409bdac4775add8db92aa22b5b718fb8c94a1462c1fe9a416b9=
5d8a3388c2fc
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: c617c1a8b1ee2a811c28b5a81b4c83d7c98b5b0c27281d610207=
ebe692c2967f
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: c90f336617b8e7f983975413c997f10b73eb267fd8a10cb9e3bd=
bfc667abdb8b
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: cb6b858b40d3a098765815b592c1514a49604fafd60819da88d7=
a76e9778fef7
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: ce3bfabe59d67ce8ac8dfd4a16f7c43ef9c224513fbc655957d7=
35fa29f540ce
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: d8cbeb9735f5672b367e4f96cdc74969615d17074ae96c724d42=
ce0216f8f3fa
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: e92c22eb3b5642d65c1ec2caf247d2594738eebb7fb3841a4495=
6f59e2b0d1fa
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: fddd6e3d29ea84c7743dad4a1bdbc700b5fec1b391f932409086=
acc71dd6dbd8
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: fe63a84f782cc9d3fcf2ccf9fc11fbd03760878758d26285ed12=
669bdc6e6d01
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: fecfb232d12e994b6d485d2c7167728aa5525984ad5ca61e7516=
221f079a1436
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: ca171d614a8d7e121c93948cd0fe55d39981f9d11aa96e03450a=
415227c2c65b
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 55b99b0de53dbcfe485aa9c737cf3fb616ef3d91fab599aa7cab=
19eda763b5ba
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 77dd190fa30d88ff5e3b011a0ae61e6209780c130b535ecb87e6=
f0888a0b6b2f
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: c83cb13922ad99f560744675dd37cc94dcad5a1fcba6472fee34=
1171d939e884
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 3b0287533e0cc3d0ec1aa823cbf0a941aad8721579d1c499802d=
d1c3a636b8a9
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 939aeef4f5fa51e23340c3f2e49048ce8872526afdf752c3a7f3=
a3f2bc9f6049
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 64575bd912789a2e14ad56f6341f52af6bf80cf94400785975e9=
f04e2d64d745
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 45c7c8ae750acfbb48fc37527d6412dd644daed8913ccd8a24c9=
4d856967df8e
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 81d8fb4c9e2e7a8225656b4b8273b7cba4b03ef2e9eb20e0a029=
1624eca1ba86
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: b92af298dc08049b78c77492d6551b710cd72aada3d77be54609=
e43278ef6e4d
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: e19dae83c02e6f281358d4ebd11d7723b4f5ea0e357907d5443d=
ecc5f93c1e9d
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 39dbc2288ef44b5f95332cb777e31103e840dba680634aa806f5=
c9b100061802
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 32f5940ca29dd812a2c145e6fc89646628ffcc7c7a42cae51233=
7d8d29c40bbd
      - SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
        SignatureData: 10d45fcba396aef3153ee8f6ecae58afe8476a280a2026fc71f6=
217dcf49ba2f
- EventNum: 7
  PCRIndex: 7
  EventType: EV_SEPARATOR
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: df3f619804a92fdb4057192dc43dd748ea778adc52bc498ce80524c014b8111=
9
  EventSize: 4
  Event: '00000000'
- EventNum: 8
  PCRIndex: 2
  EventType: EV_EFI_BOOT_SERVICES_DRIVER
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: 324ab169c198be9c7f4ea3c643642b87590aeda064dbed3ce817d243790547a=
d
  EventSize: 84
  Event:
    ImageLocationInMemory: 794439704
    ImageLengthInMemory: 132528
    ImageLinkTimeAddress: 0
    LengthOfDevicePath: 52
    DevicePath: PciRoot(0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Offset(0xee00,0x1fdf=
f)
- EventNum: 9
  PCRIndex: 1
  EventType: EV_EFI_HANDOFF_TABLES
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: d2238e9d71970be3640cbbc06d58ece1078e18b2a22c35c9bff7faeea0dcc87=
e
  EventSize: 32
  Event: 01000000000000004415fdf294972c4a992ee5bbcf20e3940060d13e00000000
- EventNum: 10
  PCRIndex: 5
  EventType: EV_EFI_VARIABLE_BOOT
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: 9d516d59bf697cabc00ae022bbfcdf88f8227c026a00e1aa8a02c6173fd2e87=
a
  EventSize: 58
  Event:
    VariableName: 61dfe48b-ca93-d211-aa0d-00e098032b8c
    UnicodeNameLength: 9
    VariableDataLength: 8
    UnicodeName: BootOrder
    VariableData:
    - Boot0003
    - Boot2001
    - Boot2002
    - Boot2003
- EventNum: 11
  PCRIndex: 5
  EventType: EV_EFI_VARIABLE_BOOT
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: fb953c3ade37d7438f53d77c10044adb24ab7519b40cc0302034e4e0e93cf16=
5
  EventSize: 348
  Event:
    VariableName: 61dfe48b-ca93-d211-aa0d-00e098032b8c
    UnicodeNameLength: 8
    VariableDataLength: 300
    UnicodeName: Boot0003
    VariableData:
      Enabled: 'Yes'
      FilePathListLength: 116
      Description: Windows Boot Manager
      DevicePath: HD(1,GPT,f6f2ba16-bb89-4242-8dd2-cecbf146c7ce,0x800,0x820=
00)/File(\EFI\Microsoft\Boot\bootmgfw.efi)
- EventNum: 12
  PCRIndex: 5
  EventType: EV_EFI_VARIABLE_BOOT
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: 0c7c99b95a506ed44fb0816181e8e3a3a02d28c14df69d7e440b1ca64fef8c7=
4
  EventSize: 90
  Event:
    VariableName: 61dfe48b-ca93-d211-aa0d-00e098032b8c
    UnicodeNameLength: 8
    VariableDataLength: 42
    UnicodeName: Boot2001
    VariableData:
      Enabled: 'Yes'
      FilePathListLength: 4
      Description: EFI USB Device
      DevicePath: <bad path>
- EventNum: 13
  PCRIndex: 5
  EventType: EV_EFI_VARIABLE_BOOT
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: 2acfbd80332f202797d5cef9f3be599db9ed7fa826c7c8dbbb216f813a1d74b=
1
  EventSize: 88
  Event:
    VariableName: 61dfe48b-ca93-d211-aa0d-00e098032b8c
    UnicodeNameLength: 8
    VariableDataLength: 40
    UnicodeName: Boot2002
    VariableData:
      Enabled: 'Yes'
      FilePathListLength: 4
      Description: EFI DVD/CDROM
      DevicePath: <bad path>
- EventNum: 14
  PCRIndex: 5
  EventType: EV_EFI_VARIABLE_BOOT
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: fb1bc2fbbbf7e3cc3ab77af1eb4f0fe772dace6b26c7bad60b66fc1f9d54bab=
e
  EventSize: 84
  Event:
    VariableName: 61dfe48b-ca93-d211-aa0d-00e098032b8c
    UnicodeNameLength: 8
    VariableDataLength: 36
    UnicodeName: Boot2003
    VariableData:
      Enabled: 'Yes'
      FilePathListLength: 4
      Description: EFI Network
      DevicePath: <bad path>
- EventNum: 15
  PCRIndex: 5
  EventType: EV_EFI_ACTION
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: 3d6772b4f84ed47595d72a2c4c5ffd15f5bb72c7507fe26f2aaee2c69d5633b=
a
  EventSize: 40
  Event: Calling EFI Application from Boot Option
- EventNum: 16
  PCRIndex: 0
  EventType: EV_SEPARATOR
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: df3f619804a92fdb4057192dc43dd748ea778adc52bc498ce80524c014b8111=
9
  EventSize: 4
  Event: '00000000'
- EventNum: 17
  PCRIndex: 1
  EventType: EV_SEPARATOR
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: df3f619804a92fdb4057192dc43dd748ea778adc52bc498ce80524c014b8111=
9
  EventSize: 4
  Event: '00000000'
- EventNum: 18
  PCRIndex: 2
  EventType: EV_SEPARATOR
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: df3f619804a92fdb4057192dc43dd748ea778adc52bc498ce80524c014b8111=
9
  EventSize: 4
  Event: '00000000'
- EventNum: 19
  PCRIndex: 3
  EventType: EV_SEPARATOR
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: df3f619804a92fdb4057192dc43dd748ea778adc52bc498ce80524c014b8111=
9
  EventSize: 4
  Event: '00000000'
- EventNum: 20
  PCRIndex: 4
  EventType: EV_SEPARATOR
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: df3f619804a92fdb4057192dc43dd748ea778adc52bc498ce80524c014b8111=
9
  EventSize: 4
  Event: '00000000'
- EventNum: 21
  PCRIndex: 5
  EventType: EV_SEPARATOR
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: df3f619804a92fdb4057192dc43dd748ea778adc52bc498ce80524c014b8111=
9
  EventSize: 4
  Event: '00000000'
- EventNum: 22
  PCRIndex: 6
  EventType: EV_SEPARATOR
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: df3f619804a92fdb4057192dc43dd748ea778adc52bc498ce80524c014b8111=
9
  EventSize: 4
  Event: '00000000'
- EventNum: 23
  PCRIndex: 7
  EventType: EV_EFI_VARIABLE_AUTHORITY
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: 30bf464ee37f1bc0c7b1a5bf25eced275347c3ab1492d5623ae9f7663be07dd=
5
  EventSize: 1551
  Event:
    VariableName: cbb219d7-3a3d-9645-a3bc-dad00e67656f
    UnicodeNameLength: 2
    VariableDataLength: 1515
    UnicodeName: db
    VariableData:
      SignatureOwner: 77fa9abd-0359-4d32-bd60-28f4e78f784b
      SignatureData: 308205d7308203bfa003020102020a61077656000000000008300d=
06092a864886f70d01010b0500308188310b300906035504061302555331133011060355040=
8130a57617368696e67746f6e3110300e060355040713075265646d6f6e64311e301c060355=
040a13154d6963726f736f667420436f72706f726174696f6e31323030060355040313294d6=
963726f736f667420526f6f7420436572746966696361746520417574686f72697479203230=
3130301e170d3131313031393138343134325a170d3236313031393138353134325a3081843=
10b3009060355040613025553311330110603550408130a57617368696e67746f6e3110300e=
060355040713075265646d6f6e64311e301c060355040a13154d6963726f736f667420436f7=
2706f726174696f6e312e302c060355040313254d6963726f736f66742057696e646f777320=
50726f64756374696f6e20504341203230313130820122300d06092a864886f70d010101050=
00382010f003082010a0282010100dd0cbba2e42e09e3e7c5f79669bc0021bd693333efad04=
cb5480ee0683bbc52084d9f7d28bf338b0aba4ad2d7c627905ffe34a3f04352070e3c4e76be=
09cc03675e98a31dd8d70e5dc37b5744696285b8760232cbfdc47a567f751279e72eb07a6c9=
b91e3b53357ce5d3ec27b9871cfeb9c923096fa84691c16e963c41d3cba33f5d026a4dec691=
f25285c36fffd43150a94e019b4cfdfc212e2c25b27ee2778308b5b2a096b22895360162cc0=
681d53baec49f39d618c85680973445d7da2542bdd79f715cf355d6c1c2b5ccebc9c238b6f6=
eb526d93613c34fd627aeb9323b41922ce1c7cd77e8aa544ef75c0b048765b44318a8b2e06d=
1977ec5a24fa48030203010001a38201433082013f301006092b06010401823715010403020=
100301d0603551d0e04160414a92902398e16c49778cd90f99e4f9ae17c55af53301906092b=
0601040182371402040c1e0a00530075006200430041300b0603551d0f040403020186300f0=
603551d130101ff040530030101ff301f0603551d23041830168014d5f656cb8fe8a25c6268=
d13d94905bd7ce9a18c430560603551d1f044f304d304ba049a0478645687474703a2f2f637=
26c2e6d6963726f736f66742e636f6d2f706b692f63726c2f70726f64756374732f4d696352=
6f6f4365724175745f323031302d30362d32332e63726c305a06082b06010505070101044e3=
04c304a06082b06010505073002863e687474703a2f2f7777772e6d6963726f736f66742e63=
6f6d2f706b692f63657274732f4d6963526f6f4365724175745f323031302d30362d32332e6=
37274300d06092a864886f70d01010b0500038202010014fc7c7151a579c26eb2ef393ebc3c=
520f6e2b3f101373fea868d048a6344d8a960526ee3146906179d6ff382e456bf4c0e528b8d=
a1d8f8adb09d71ac74c0a36666a8cec1bd70490a81817a49bb9e240323676c4c15ac6bfe404=
c0ea16d3acc368ef62acdd546c503058a6eb7cfe94a74e8ef4ec7c867357c2522173345af3a=
38a56c804da0709edf88be3cef47e8eaef0f60b8a08fb3fc91d727f53b8ebbe63e0e33d3165=
b081e5f2accd16a49f3da8b19bc242d090845f541dff89eaba1d47906fb0734e419f409f5fe=
5a12ab21191738a2128f0cede73395f3eab5c60ecdf0310a8d309e9f4f69685b67f51886647=
198da2b0123d812a680577bb914c627bb6c107c7ba7a8734030e4b627a99e9cafcce4a37c92=
da4577c1cfe3ddcb80f5afad6c4b30285023aeab3d96ee4692137de81d1f675190567d39357=
5e291b39c8ee2de1cde445735bd0d2ce7aab1619824658d05e9d81b367af6c35f2bce53f24e=
235a20a7506f6185699d4782cd1051bebd088019daa10f105dfba7e2c63b7069b2321c4f978=
6ce2581706362b911203cca4d9f22dbaf9949d40ed1845f1ce8a5c6b3eab03d370182a0a6ae=
05f47d1d5630a32f2afd7361f2a705ae5425908714b57ba7e8381f0213cf41cc1c5b990930e=
88459386e9b12099be98cbc595a45d62d6a0630820bd7510777d3df345b99f979fcb57806f3=
3a904cf77a4621c597e
- EventNum: 24
  PCRIndex: 5
  EventType: EV_EFI_GPT_EVENT
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: af6a177bc8d8464d0a8132ac60293a56aa2e350eea122d8f316d28bab7c63b4=
b
  EventSize: 612
  Event:
    Header:
      Signature: EFI PART
      Revision: 0x10000
      HeaderSize: 92
      HeaderCRC32: 0x4607d893
      MyLBA: 0x1
      AlternateLBA: 0x3b9e12af
      FirstUsableLBA: 0x22
      LastUsableLBA: 0x3b9e128e
      DiskGuid: d1a0ad52-7e5f-4717-965b-24975d685054
      PartitionEntryLBA: 0x2
      NumberOfPartitionEntries: 128
      SizeOfPartitionEntry: 128
      PartitionEntryArrayCRC: 0xb2f4c60f
    NumberOfPartitions: 4
    Partitions:
    - PartitionTypeGUID: c12a7328-f81f-11d2-ba4b-00a0c93ec93b
      UniquePartitionGUID: f6f2ba16-bb89-4242-8dd2-cecbf146c7ce
      StartingLBA: 0x800
      EndingLBA: 0x827ff
      Attributes: 0x8000000000000000
      PartitionName: EFI system partition
    - PartitionTypeGUID: e3c9e316-0b5c-4db8-817d-f92df00215ae
      UniquePartitionGUID: 1a5731d6-a09d-43b3-886a-e342560c5f49
      StartingLBA: 0x82800
      EndingLBA: 0x8a7ff
      Attributes: 0x8000000000000000
      PartitionName: Microsoft reserved partition
    - PartitionTypeGUID: ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
      UniquePartitionGUID: 3bd5aaaf-ce3b-4609-80ab-c52f79c80999
      StartingLBA: 0x8a800
      EndingLBA: 0x3b7ecfff
      Attributes: 0x0
      PartitionName: Basic data partition
    - PartitionTypeGUID: de94bba4-06d1-4d40-a16a-bfd50179d6ac
      UniquePartitionGUID: 60d1f406-21e0-46c5-9023-c773cb2172fc
      StartingLBA: 0x3b7ed000
      EndingLBA: 0x3b9e0fff
      Attributes: 0x8000000000000001
      PartitionName: Basic data partition
- EventNum: 25
  PCRIndex: 4
  EventType: EV_EFI_BOOT_SERVICES_APPLICATION
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: 41796e6fd1976f3750bfb26d6b00e773478ea8d0fe1b67f638bbbc098bf8008=
a
  EventSize: 176
  Event:
    ImageLocationInMemory: 760659992
    ImageLengthInMemory: 1557816
    ImageLinkTimeAddress: 268435456
    LengthOfDevicePath: 144
    DevicePath: PciRoot(0x0)/Pci(0x17,0x0)/Sata(512,32768,0)/HD(1,GPT,f6f2b=
a16-bb89-4242-8dd2-cecbf146c7ce,0x800,0x82000)/File(\EFI\Microsoft\Boot\boo=
tmgfw.efi)
- EventNum: 26
  PCRIndex: 11
  EventType: EV_COMPACT_HASH
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: 097328e8c957de2428283954f6a1ee8ff7ad7def12e100a600178407f5decf2=
4
  EventSize: 4
  Event: '10000000'
- EventNum: 27
  PCRIndex: 12
  EventType: EV_EVENT_TAG
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: c14b8ee083b10861666ed0c22ba3994c124f87cc62eaa8df10d318e511e3e07=
7
  EventSize: 280
  Event: 010001401001000007000200080000000100410100000000060002000800000000=
0d0000000000000200020008000000750000000000000003000140380000000400070020000=
0006c94a7b550209afdf06c87441a9795f81567e1459fa03d5ed6a36c84ef8adcd707000700=
08000000005034000000000003000140380000000400070020000000fd49bb8148d48b1adc6=
ee72fccece025fe97b41213b68685e6b4ad6147698de7070007000800000000e09000000000=
000900020004000000010000000a00020004000000000000000300020004000000010000000=
100040001000000000300050001000000002100050001000000000200050001000000010500=
020004000000000000000b0002000400000000000000
- EventNum: 28
  PCRIndex: 13
  EventType: EV_EVENT_TAG
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: 081567da817e25da71e1363864081a4aaaac979388f90fd27c320ff02253e9d=
7
  EventSize: 916
  Event: 010001408c0300000900020004000000010000000a000200040000000000000001=
000400010000000003000500010000000021000500010000000002000500010000000105000=
20004000000000000000b000200040000000000000029000500340000000100000014000000=
0b0020000000000000000000ece4c1841c6a72fa3f782e2b2139e338d78abd41761f8952f56=
91797712bacda020004002e00000080a19aad7073d301200000000b0076dea1e54ada0c2e76=
5bdb30099a573965ace595bd9af0dd82429c3ef3780cf303000140620100000100070056000=
0005c004500460049005c004d006900630072006f0073006f00660074005c0042006f006f00=
74005c0065006e002d00550053005c0062006f006f0074006d006700660077002e006500660=
069002e004d005500490000000200070008000000002001000000000003000700040000000c=
80000004000700200000006c94a7b550209afdf06c87441a9795f81567e1459fa03d5ed6a36=
c84ef8adcd70a0007000100000001050007004c0000004d006900630072006f0073006f0066=
0074002000570069006e0064006f00770073002000500072006f00640075006300740069006=
f006e00200050004300410020003200300031003100000008000700240000004d0069006300=
72006f0073006f00660074002000570069006e0064006f00770073000000060007001300000=
0330000023241fb59996dcc4dff0000000002320900070014000000ff82bc38e1da5e596df3=
74c53e3617f7eda36b060300014054010000010007003c0000005c00570049004e0044004f0=
0570053005c00730079007300740065006d00330032005c00770069006e006c006f00610064=
002e0065006600690000000200070008000000000020000000000003000700040000000c800=
0000400070020000000fd49bb8148d48b1adc6ee72fccece025fe97b41213b68685e6b4ad61=
47698de70a0007000100000001050007004c0000004d006900630072006f0073006f0066007=
4002000570069006e0064006f00770073002000500072006f00640075006300740069006f00=
6e00200050004300410020003200300031003100000008000700240000004d0069006300720=
06f0073006f00660074002000570069006e0064006f00770073000000060007001300000033=
00000266bd1580efa75cd6d30000000002660900070014000000a4341b9fd50fb9964283220=
a36a1ef6f6faa78400b0007000400000001000000
- EventNum: 29
  PCRIndex: 14
  EventType: EV_EVENT_TAG
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: 56b5e2611e00f475c7f1c5f1eb2df5173e01c61099423775b9650e9a666ea4a=
8
  EventSize: 302
  Event: 020006002601000030820122300d06092a864886f70d01010105000382010f0030=
82010a0282010100dd0cbba2e42e09e3e7c5f79669bc0021bd693333efad04cb5480ee0683b=
bc52084d9f7d28bf338b0aba4ad2d7c627905ffe34a3f04352070e3c4e76be09cc03675e98a=
31dd8d70e5dc37b5744696285b8760232cbfdc47a567f751279e72eb07a6c9b91e3b53357ce=
5d3ec27b9871cfeb9c923096fa84691c16e963c41d3cba33f5d026a4dec691f25285c36fffd=
43150a94e019b4cfdfc212e2c25b27ee2778308b5b2a096b22895360162cc0681d53baec49f=
39d618c85680973445d7da2542bdd79f715cf355d6c1c2b5ccebc9c238b6f6eb526d93613c3=
4fd627aeb9323b41922ce1c7cd77e8aa544ef75c0b048765b44318a8b2e06d1977ec5a24fa4=
8030203010001
- EventNum: 30
  PCRIndex: 12
  EventType: EV_EVENT_TAG
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: e65898200a0403ac304056ee60c14bfc1964bda495f358b4a2a985b04531b3b=
3
  EventSize: 6051
  Event: 010001409b1700000900020004000000010000000a000200040000000000000003=
0001403800000004000700200000002a24945417ae8dd109958de57db82aa32f5da3398c876=
338e767f76890c6ddf0070007000800000000a01f0000000000030001403800000004000700=
20000000ac85a09f1021140b3250c9ec4f5b94e690c1974be6efd005bc4d95e5ac38866f070=
007000800000000407c00000000000300014038000000040007002000000032c83aecb3cea9=
c0e6276e9ac61d40324d2bbff5c326c49ec6740e368e57671b07000700080000000000c0020=
00000000300014038000000040007002000000008c8089ba7150f28c8821989186f95891f0d=
85a7a9ac845386e704672d62b1ac07000700080000000000000300000000030001403800000=
00400070020000000971fe367e613c98c6282771f75d2386cdf369f5f9cbd4f5f81baf9a969=
d5131c07000700080000000000e90200000000030001403800000004000700200000003c036=
5e1d3c24e6a0235ab4d160081ef27ebe21a4e71b04aab6f57a0b1f5148f0700070008000000=
0000ea02000000000300014038000000040007002000000052e46a70ff6892437796f4bc812=
43db28faf52c270fb76b79e24bd9d718cc7d907000700080000000000ea0200000000030001=
40380000000400070020000000cc70cb5fe2f01f54c93227f02123025a1f39fb8cfa54410c0=
1e79788b87b4b5707000700080000000000ea02000000000300014038000000040007002000=
0000ce97c9e21a2d579f150cb1cb24a0505b5df20f9aabb661de7814585577b612000700070=
0080000000000ea020000000003000140380000000400070020000000db24856eb4084ce839=
f65eddf7254e54bde0510b1faea3890fa12ee34b7fb33007000700080000000000eb0200000=
00003000140380000000400070020000000898412c88d76ef6e0bef9b4340ae2cacbed17492=
2dcd029e00b001a936b2196d07000700080000000000ee02000000000300014038000000040=
0070020000000a425409a4886699584e82933e5c89e1f3dc48163493efa10786266d3a0ddd0=
9a07000700080000000000f502000000000300014038000000040007002000000038962e739=
417217077888f561d0a2e3a9bde186f1ad0f6df481ae3f06e85b59b07000700080000000000=
f70200000000030001403800000004000700200000007b1e8f3773bdeb7d7792e82f1d98470=
74051029728a9bc4563b2c89ef02d67a2070007000800000000004004000000000300014038=
000000040007002000000070b0347b4d51d75dbe626193e4d6cec80f4c9d6931a355cc3a451=
6135bc1b23407000700080000000000f8020000000003000140380000000400070020000000=
138848a7643bd1f7fefd86102bc2e8a3
- EventNum: 31
  PCRIndex: 13
  EventType: EV_EVENT_TAG
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: 51489a05ccd19aef31d0ca7eeab0d3decd9a18c786e634fe773c01c05b76959=
5
  EventSize: 33144
  Event: 01000140708100000900020004000000010000000a000200040000000000000001=
000500010000000008000500040000000400010009000500120000005c00570049004e00440=
04f005700530000000400050008000000000000000000000005000500010000000006000500=
01000000000a000500080000000000000000000000120005000800000000000000000000002=
200050001000000002400050001000000002500050001000000002600050001000000000e00=
050004000000010000001400050004000000010000000100040001000000000300050001000=
000002100050001000000000200050001000000010500020004000000000000000b00020004=
00000000000000290005003400000001000000140000000b0020000000000000000000ece4c=
1841c6a72fa3f782e2b2139e338d78abd41761f8952f5691797712bacda020004002e000000=
80a19aad7073d301200000000b0076dea1e54ada0c2e765bdb30099a573965ace595bd9af0d=
d82429c3ef3780cf3130005002e000000806642a57073d301200000000b001bab1978c5b112=
9914361dc69ea6093a31472053d2c62945551eb2772e387cde030001408d010000010007005=
60000005c00570049004e0044004f00570053005c00730079007300740065006d0033003200=
5c0044005200490056004500520053005c00660069006c0065005f0074007200610063006b0=
0650072002e007300790073000000020007000800000000b005000000000003000700040000=
000480000004000700140000009fbf39df5d9c9115dee98929f1803646048146390a0007000=
1000000010500070074000000530079006d0061006e00740065006300200043006c00610073=
00730020003300200045007800740065006e006400650064002000560061006c00690064006=
100740069006f006e00200043006f006400650020005300690067006e0069006e0067002000=
4300410020002d00200047003200000008000700360000004100630072006f006e006900730=
0200049006e007400650072006e006100740069006f006e0061006c00200047004d00420048=
00000006000700100000007701f7622847c9d6407e2f567e2764000900070014000000d2758=
46016ee7a1501b2ed00b56cd8af7c88312603000140da01000001000700780000005c005700=
49004e0044004f00570053005c00530079007300740065006d00330032005c0064007200690=
076006500720073005c004e00470043007800360034005c0031003600310034003000350030=
002e003000320037005c00530059004d0045004600410053004900360034002e00530059005=
3000000020007000800000000501e000000000003000700040000000c800000040007002000=
0000c07019c1c2e5504f735f33a0190b
- EventNum: 32
  PCRIndex: 14
  EventType: EV_EVENT_TAG
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: 8b845a66c7bdd3f2b642061dbfceb384a5d025a3eda93f15a0054ad503a0cae=
b
  EventSize: 1216
  Event: 01000140b8040000020006002601000030820122300d06092a864886f70d010101=
05000382010f003082010a0282010100dd0cbba2e42e09e3e7c5f79669bc0021bd693333efa=
d04cb5480ee0683bbc52084d9f7d28bf338b0aba4ad2d7c627905ffe34a3f04352070e3c4e7=
6be09cc03675e98a31dd8d70e5dc37b5744696285b8760232cbfdc47a567f751279e72eb07a=
6c9b91e3b53357ce5d3ec27b9871cfeb9c923096fa84691c16e963c41d3cba33f5d026a4dec=
691f25285c36fffd43150a94e019b4cfdfc212e2c25b27ee2778308b5b2a096b22895360162=
cc0681d53baec49f39d618c85680973445d7da2542bdd79f715cf355d6c1c2b5ccebc9c238b=
6f6eb526d93613c34fd627aeb9323b41922ce1c7cd77e8aa544ef75c0b048765b44318a8b2e=
06d1977ec5a24fa48030203010001020006002601000030820122300d06092a864886f70d01=
010105000382010f003082010a0282010100e90e64507967b5c4e3fd09004c9e94acf75668e=
a44d8cfc5584fa9a5767c6d45bad33992b4a41ef9f96582e417d28ffd449c08e86593ce2c55=
84bf7d08e32e2ba8412b18b7a24b6e494c6b1507ded1d2c2891e7194cdb57f4bb4af08d8cc8=
8d66b17943a93ce263fece6fe349857d51d5d49f6b22a2ed585bb593ff890b42b8374ca2bb3=
3b46e3f04649c1176654c91cbd1dc455625772f867b9252034de5da6a5955eab2880cdd5b29=
ee503b563d3b214c8c1c88a260a597f07ecff0eed8012354c12a6be525bf5a6dae08b0b4877=
d68547d510b9c6e8aaee8b6a2d055c60c6b42a5b9c231c5f45e31a141e6f37cb1933806a894=
da36a66637893d530cf951f0203010001020006002601000030820122300d06092a864886f7=
0d01010105000382010f003082010a0282010100d01802eeeda28d0858630f26d7dd227b88f=
6e4c7ec3b261878d3c7a420538d837ca53f7ea5c82b47df0df5a6d9c31d259360cf7cdcea03=
2cbe787f5c486da702d949f8a1ebeb9a617c9fc026d6dc15d8b8107c20ba5ef428f6a8eaa75=
c7cc69c9090343cb622acfeba0c3a1ed65e84b65bf0a38170788a8d46527bfcdb49f3291311=
744f8d16b3c2e3a02dc703049dccc372e10e0cfb028ef126177b6eaef8b7338ba6614b45dff=
22544c7f7b0982336dc28790ae89b7288a8d8e8ae7b7f0a6445a5f057929a7706451eeb9fe8=
66f37a7d92815f002d1eb8f656135a620db747a18f72ef835e82e09498e1aca5ad8637e0a7d=
3bab13e7aeb45a8f1c1447de2030203010001020006002601000030820122300d06092a8648=
86f70d01010105000382010f003082010a0282010100a39c308409a7632ecf0a47f0ea24f9a=
330200f5e573126819a3107b250d4ce670908650a5aa54baed5ed102ee7a599b59f682f988b=
5802ac20b429c471bd281ca5fd3c9b64
- EventNum: 33
  PCRIndex: 11
  EventType: EV_COMPACT_HASH
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: 08efea1c0957a5a1fe019e6edb21fdc9fbe5de2213487eab7a05e06eca1c978=
4
  EventSize: 4
  Event: ffff0000
- EventNum: 34
  PCRIndex: 12
  EventType: EV_SEPARATOR
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: 4613c07447240b20cf1baa3fd4441a3f1b62bea1e9aaaa0678532b83ce9de25=
4
  EventSize: 4
  Event: 5742434c
- EventNum: 35
  PCRIndex: 13
  EventType: EV_SEPARATOR
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: 4613c07447240b20cf1baa3fd4441a3f1b62bea1e9aaaa0678532b83ce9de25=
4
  EventSize: 4
  Event: 5742434c
- EventNum: 36
  PCRIndex: 14
  EventType: EV_SEPARATOR
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: 4613c07447240b20cf1baa3fd4441a3f1b62bea1e9aaaa0678532b83ce9de25=
4
  EventSize: 4
  Event: 5742434c
- EventNum: 37
  PCRIndex: 5
  EventType: EV_EFI_ACTION
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: d8043d6b7b85ad358eb3b6ae6a873ab7ef23a26352c5dc4faa5aeedacf5eb41=
b
  EventSize: 29
  Event: Exit Boot Services Invocation
- EventNum: 38
  PCRIndex: 5
  EventType: EV_EFI_ACTION
  DigestCount: 1
  Digests:
  - AlgorithmId: sha256
    Digest: b54f7542cbd872a81a9d9dea839b2b8d747c7ebd5ea6615c40f42f44a6dbeba=
0
  EventSize: 40
  Event: Exit Boot Services Returned with Success


